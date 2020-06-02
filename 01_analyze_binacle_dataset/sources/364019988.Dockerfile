FROM node:0.10.40-slim
MAINTAINER Rajesh Raheja "rajesh.raheja@ca.com"
LABEL Description="Docker container for the TestDoubles app. Includes CLI, REST APIs, TD, NodeJS and Mountebank."

# Setup TestDoubles environment
ENV TD_USER td
ENV TD_ROOT /opt/testdoubles
ENV TD_HOME ${TD_ROOT}/node_modules/testdoubles
ENV PATH ${TD_HOME}/bin:$PATH
ENV TD_HOST http://localhost:5050
ENV TD_PORT 5050
ENV NODE_ENV production

# Install and configure system
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -r ${TD_USER} && \
    useradd -r -m -g ${TD_USER} ${TD_USER} && \
    mkdir -p ${TD_HOME}/testdoubles && \
    mkdir -p ${TD_HOME}/logs && \
    chown -R ${TD_USER} ${TD_ROOT} && \
    chgrp -R ${TD_USER} ${TD_ROOT} && \
    chmod 777 ${TD_HOME}/testdoubles && \
    chmod 777 ${TD_HOME}/logs 

# Install TestDoubles from the npm registry and start the processes
EXPOSE 2525 5050 5051
USER ${TD_USER}
WORKDIR ${TD_ROOT}
RUN npm install testdoubles --production
WORKDIR ${TD_HOME}
CMD ["tdctl", "start"]
