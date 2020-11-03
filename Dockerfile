FROM mysql:latest

WORKDIR /docker-entrypoint-initdb.d/

# needed for intialization
ENV MYSQL_ROOT_PASSWORD=root

COPY *.sql ./
