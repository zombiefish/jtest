FROM  repo.sofvie.com:5001/mariadb:10.5.9
LABEL maintainer="Sofvie Inc."
LABEL version="3"

RUN mkdir /etc/mysql/encryption
COPY data/keyfile.enc /etc/mysql/encryption/
COPY data/*.sql.gz /docker-entrypoint-initdb.d/

EXPOSE 3306

CMD ["mysqld"]
