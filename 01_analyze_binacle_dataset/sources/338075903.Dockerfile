FROM alpine:latest
LABEL Author="Ståle Dahl <stalehd@telenordigital.com>"
LABEL Description="Congress docker image"
ADD ./server /congress
ENV CONGRESS_LOGLEVEL=2
ENV CONGRESS_DB=--memorydb
ENV CONGRESS_AUTH=
EXPOSE 8080
# Expose this port but the Congress server only responds on the loopback
# adapter for this port. This might change in the future.
EXPOSE 8081

ENTRYPOINT /congress/congress ${CONGRESS_DB} ${CONGRESS_AUTH} --plainlog --loglevel ${CONGRESS_LOGLEVEL}
