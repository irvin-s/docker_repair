# Builds the Webserver Docker file.
# We expect the release folder to contain all the static files. This can be achieved by running
# python collect-files.py .\dist --force
FROM nginx

COPY release www
COPY ucca.conf /etc/nginx/conf.d/default.conf