FROM vapor

# Install postgresql
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y apt-utils sudo

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql postgresql-client postgresql-contrib libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY setup.sh /tmp/setup.sh
COPY setup.sql /tmp/setup.sql
RUN chmod u+x /tmp/setup.sh && \
    /tmp/setup.sh && \
    rm /tmp/setup.* 

EXPOSE 5432

CMD service postgresql start && bash

# Launch the image with this command: 
# docker run -ti --rm --name vapor-postgresql -p 127.0.0.1:8080:8080 -p 127.0.0.1:5432:5432 -v postgresql.data:/var/lib/postgresql/9.5/main -v $(pwd)/vapor-postgresql/projects:/vapor vapor-postgresql
