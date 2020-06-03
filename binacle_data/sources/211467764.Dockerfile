FROM node:7.7.1

# Install ContainerPilot
ENV CONTAINERPILOT_VERSION 2.7.0
RUN export CP_SHA1=687f7d83e031be7f497ffa94b234251270aee75b \
    && curl -Lso /tmp/containerpilot.tar.gz \
         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
    && echo "${CP_SHA1}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /bin \
    && rm /tmp/containerpilot.tar.gz

# COPY ContainerPilot configuration
COPY containerpilot.json /etc/
ENV CONTAINERPILOT=file:///etc/containerpilot.json

# COPY node app
COPY package.json /opt/example/
COPY server.js /opt/example/
WORKDIR /opt/example/
RUN npm install

EXPOSE 8000
CMD ["/bin/containerpilot", "node", "/opt/example/server.js"]
