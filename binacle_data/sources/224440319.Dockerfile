FROM mhart/alpine-node:6.3.0

MAINTAINER tobilg@gmail.com

# Setup of the prerequisites
RUN apk add --no-cache git && \
    apk add --no-cache ca-certificates openssl && \
    mkdir -p /mnt/mesos/sandbox/logs && \
    npm set progress=false

# Set application name
ENV APP_NAME mesos-framework-boilerplate

# Set application directory
ENV APP_DIR /usr/local/${APP_NAME}

# Set node env to production, so that npm install doesn't install the devDependencies
ENV NODE_ENV production

# Add application
ADD . ${APP_DIR}

# Change the workdir to the app's directory
WORKDIR ${APP_DIR}

# Setup of the application
RUN npm install --silent && \
    npm install bower -g && \
    bower install --allow-root

CMD ["sh", "./get_creds.sh"]
