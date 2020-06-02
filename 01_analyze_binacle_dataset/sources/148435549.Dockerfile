FROM postgres:9.6

# Copy the text search dictionaries:
ADD pgsql/tsearch_data/*.tar.gz /usr/share/postgresql/9.6/tsearch_data/

# Initialize application's database:
COPY pgsql/schema.sql /docker-entrypoint-initdb.d/1-schema.sql
COPY pgsql/triggers.sql /docker-entrypoint-initdb.d/2-triggers.sql
COPY pgsql/views.sql /docker-entrypoint-initdb.d/3-views.sql
COPY pgsql/sprocs.sql /docker-entrypoint-initdb.d/4-sprocs.sql

ENV POSTGRES_DB cmbarter

################################################################################

# Set this to the password for the user "postgres".
ENV POSTGRES_PASSWORD mysecretpassword
