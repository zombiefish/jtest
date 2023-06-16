
# Build Slim

FROM  repo.sofvie.com:5001/node:16.15.0-slim
LABEL maintainer="Sofvie Systems Inc."
LABEL version="1.3.5.2"

ENV SQLLISTENER="/opt/sqllistener"

RUN mkdir -p $SQLLISTENER/logs  \
 && touch $SQLLISTENER/logs/listenlog.txt \
 && chown -R node:node $SQLLISTENER/logs

WORKDIR $SQLLISTENER

COPY data/package.json $SQLLISTENER/

RUN npm update

RUN npm install -g npm \
 && npm install -g npm@latest pm2 \
 && npm install -g \
 && npm cache clean --force

ADD data/sqllistener-1.3.5.2.tar.gz $SQLLISTENER/

CMD ["pm2-docker", "start", "ecosystem.config.js"]
