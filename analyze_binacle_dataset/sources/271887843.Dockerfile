FROM ubuntu
COPY search /usr/bin/
COPY static /usr/share/search
EXPOSE 8080
ENV ELASTIC_URL http://elastic:9200
ENV GIN_MODE release
ENV STATIC_FOLDER /usr/share/search/
CMD /usr/bin/search
