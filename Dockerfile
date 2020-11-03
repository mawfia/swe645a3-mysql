ARG data_copy="no"

ENV data_copy=$data_copy

FROM mysql:latest as build_yes
ONBUILD COPY *.sql .

FROM mysql:latest as build_no
ONBUILD RUN echo "No data to copy"

FROM build_${data_copy}
WORKDIR /docker-entrypoint-initdb.d/

# needed for intialization
ENV MYSQL_ROOT_PASSWORD=root

#COPY *.sql .
