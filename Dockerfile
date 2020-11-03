FROM mysql:latest as build_copy
ONBUILD COPY *.sql .

FROM mysql:latest as build_no_copy
ONBUILD RUN echo "No data to copy"

FROM build_${DATA_COPY}
WORKDIR /docker-entrypoint-initdb.d/

# needed for intialization
ENV MYSQL_ROOT_PASSWORD=root

#COPY *.sql .
