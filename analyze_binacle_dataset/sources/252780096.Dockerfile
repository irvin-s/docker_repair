FROM letsencrypt/boulder-tools:2018-03-07  
COPY . /go/src/github.com/letsencrypt/boulder  
  
# Fix this environment variable to initialize the DB for ACME V2  
ENV BOULDER_CONFIG_DIR test/config-next  
  
WORKDIR /go/src/github.com/letsencrypt/boulder  
  
ENTRYPOINT test/entrypoint.sh

