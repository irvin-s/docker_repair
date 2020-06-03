FROM mdillon/postgis

WORKDIR /mds
COPY . /mds

ENTRYPOINT [ "bin/entrypoint.sh" ]