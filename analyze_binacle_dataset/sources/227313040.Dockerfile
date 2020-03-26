FROM vapor

# Install sqlite
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y apt-utils

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y sqlite3 libsqlite3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD bash

# Launch the image with this command: 
# docker run -ti --rm --name vapor-sqlite -p 127.0.0.1:8080:8080 -v $(pwd)/vapor-sqlite/projects:/vapor vapor-sqlite
