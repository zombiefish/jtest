FROM  repo.sofvie.com:5001/python:3.10.4 AS builder
LABEL maintainer="Sofvie Inc."
LABEL version="1.3.5.2"

ENV REPORTS="/opt/reports" \
    PATH="/opt/reports/bin:$PATH" \
    PYTHONPATH="/opt/reports" \
    CREDFILE="/opt/reports/credentials.yaml"

RUN mkdir -p $REPORTS
WORKDIR $REPORTS
COPY data/requirements.txt $REPORTS/

RUN apt-get update \
 && python3 -m venv $REPORTS \
 && cd $REPORTS \
 && . $REPORTS/bin/activate
RUN  python -m pip install --upgrade pip
RUN  pip install wheel
RUN  pip install -Ur $REPORTS/requirements.txt

# Slim Build
FROM python:3.10.4-slim

ENV REPORTS="/opt/reports" \
    PATH="/opt/reports/bin:$PATH" \
    PYTHONPATH="/opt/reports" \
    CREDFILE="/opt/reports/credentials.yaml"

RUN mkdir -p $REPORTS
WORKDIR $REPORTS

COPY --from=builder $REPORTS $REPORTS

RUN apt-get update \
 && apt-get install -y apt-utils \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y nginx supervisor \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*


ADD data/reports-app-1.3.5.2.tar.gz .
COPY data/docker-entrypoint.sh /

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
