FROM ubuntu
MAINTAINER Matt Erasmus <code@zonbi.org>
RUN addgroup dvna
RUN useradd -r -g dvna -d /opt/dvna -s /bin/bash -c "DVNA User" dvna
RUN apt-get update
RUN apt-get install -yq git wget
RUN git clone https://github.com/quantumfoam/DVNA.git /opt/dvna
RUN wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh
RUN bash -c 'BASH_ENV=/root/.profile exec bash'
RUN nvm install 5.3.0
RUN nvm use 5.3.0
WORKDIR /opt/dvna
RUN chown dvna:dvna -R /opt/dvna
USER dvna
RUN npm install
RUN node vulnerabilities/command_injection.js
