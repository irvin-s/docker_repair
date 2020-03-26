FROM docker:dind
WORKDIR /toscana
VOLUME /toscana/data
# Mount the AWS Directory as volume (used to store Credentials)
VOLUME /root/.aws
COPY server.jar server.jar
COPY *.sh /toscana/
RUN apk add --update --no-cache bash && \
    ./install-deps.sh && \
    ./cleanup.sh
EXPOSE 8080
ENV DATADIR="/toscana/data"
ENV SERVER_PORT="8080"
ENTRYPOINT ./toscana-dind-entrypoint.sh
