FROM loicmahieu/alpine-envsubst AS generate_config

ARG CAS_PROFILE_URL="my-sso/oauth2.0/profile"
ARG DATABASE_HOST="localhost"
ARG DATABASE_PORT="1234"
ARG DATABASE_USERNAME="my_db_username"
ARG DATABASE_PASSWORD="my_db_password"
ARG DATABASE_DB_NAME="adh6"

WORKDIR /tmp
COPY api_server/config/ .
RUN cat CONFIGURATION.template.py | envsubst | tee CONFIGURATION.py

FROM python:3.7-slim-stretch
EXPOSE 443

# Make TLS self-signed certificate
RUN openssl genrsa -out /etc/ssl/private/adh6.key 2048 \
    && openssl req -new -key /etc/ssl/private/adh6.key -out /tmp/adh6.csr -subj "/C=FR/ST=Essonne/O=MiNET/CN=api_server" \
    && openssl x509 -req -days 365 -in /tmp/adh6.csr -signkey /etc/ssl/private/adh6.key -out /etc/ssl/certs/adh6.crt

# Install dependencies
    RUN apt update \
      && apt install -y \
      build-essential \
      python3-dev \
      libpcre3 \
      libpcre3-dev \
      libssl-dev \
      libmariadbclient-dev \
      && useradd uwsgi

WORKDIR /adh6/api_server

# Install python requirements
COPY api_server/requirements.txt ./
RUN pip3 install -r ./requirements.txt

# Build all MIBs required by pysnmp
RUN mibdump.py CISCO-VLAN-MEMBERSHIP-MIB IF-MIB CISCO-MAC-AUTH-BYPASS-MIB
RUN chmod 755 /root
RUN chown -R uwsgi:www-data /root/.pysnmp
# Copy source files
COPY ./openapi/spec.yaml ../openapi/
COPY ./api_server ./
COPY --from=generate_config /tmp/CONFIGURATION.py config/


ENV ENVIRONMENT="dev"

# Launch the app 
CMD ["uwsgi", "--ini", "uwsgi.ini"]
