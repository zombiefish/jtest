FROM  repo.sofvie.com:5001/couchdb:3.2.2
LABEL maintainer="Sofvie Inc."
LABEL version="1"

COPY data/local.ini /opt/couchdb/etc/
COPY data/createDB.sh /usr/local/bin/createDB.sh

EXPOSE 5984

CMD ["sh", "-c", "/usr/local/bin/createDB.sh & /opt/couchdb/bin/couchdb"]
