FROM debian
MAINTAINER dirkraft

RUN /usr/bin/apt-get update && DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get install -y curl
RUN DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get install -y libgtk2.0-0 libnotify4 libgconf-2-4 libnss3 xvfb
RUN /usr/bin/curl -sL https://deb.nodesource.com/setup_6.x | /bin/bash && \
        DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get install -y nodejs

WORKDIR /opt/nightmare-server
COPY . .
RUN /usr/bin/npm install

CMD /usr/bin/xvfb-run ./server.js
EXPOSE 3000
