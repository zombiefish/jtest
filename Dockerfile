FROM python:3.8 AS builder
LABEL maintainer="Sofvie Inc."
LABEL version="1.3.5.2"

ENV API="/opt/api" \
    PATH="/opt/api/bin:$PATH" \
    PYTHONPATH="/opt/api"

# set up base container
RUN mkdir -p $API /var/log/uwsgi /home/webadmin/keys/

WORKDIR $API
COPY data/requirements.txt $API/

# update python modules
RUN python3 -m venv $API \
 && cd $API \
 && . $API/bin/activate \
 && python3 -m pip install --upgrade pip \
 && pip install -Ur $API/requirements.txt

# Slim Build

FROM python:3.8-slim
LABEL maintainer="Sofvie Inc."
LABEL version="1.3.5.2"

ENV API="/opt/api" \
    PATH="/opt/api/bin:$PATH" \
    PYTHONPATH="/opt/api" \
    BASE="/opt/api/lib/python3.8/site-packages/django/db/backends/mysql/base.py"

# open ports for images and api
EXPOSE 80
EXPOSE 8000

WORKDIR $API

COPY --from=builder /opt/api /opt/api
COPY data/docker-entrypoint.sh data/schedule_report.py $API/

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nginx cargo uwsgi supervisor \
 && mkdir -p $API /var/log/uwsgi /home/webadmin/keys/ \
 && chmod +x $API/schedule_report.py \
 && rm -f /etc/nginx/sites-enabled/default \
     /etc/nginx/sites-available/default

# install the code
ADD data/*-key.pem /home/webadmin/keys/
ADD data/api-1.3.5.2.tar.gz .

# fix some of the source code files
# RUN sed -i 's/^  host:.*/  host: "db",/g' apps/language/api/views/translationimportutility3.0.js

# && sed -i "s/  kwargs\['port'\].*/kwargs\['port'\] = 3306/g" $BASE \
# && sed -i "/PORT/d" $BASE

# for schedule_report.py when devs push prod code
# RUN sed -i 's,with open.*,with open("/opt/api/sofvie_api/.env") as f:,g' /opt/api/schedule_report.py \

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
