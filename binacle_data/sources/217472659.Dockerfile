from openjdk:8


COPY rsterminology-server-1.1-SNAPSHOT.jar rsterminology-server.jar
COPY config.yml config.yml
COPY uk_sct1cl_*.zip snomedCT.zip
COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
RUN unzip snomedCT.zip
EXPOSE 8080

CMD ./docker-entrypoint.sh
