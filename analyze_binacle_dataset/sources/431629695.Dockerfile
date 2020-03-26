FROM appropriate/curl
MAINTAINER Ivan Sim, ihcsim@gmail.com

ENV MAX_RETRIES=100
COPY test/http.sh /test/http.sh
WORKDIR /test
ENTRYPOINT ["/bin/sh"]
