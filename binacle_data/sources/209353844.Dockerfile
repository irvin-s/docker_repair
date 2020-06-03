FROM mdillon/postgis:9.5

COPY ./load_db_data.sh /docker-entrypoint-initdb.d/postgis.sh

EXPOSE 5432
CMD ["postgres"]