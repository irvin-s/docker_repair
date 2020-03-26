FROM node:8.16-stretch as builder

# Create app directories
ENV WEDEPLOY_ELECTRIC_DIRECTORY=/electric
ENV WEDEPLOY_MAGNET_DIRECTORY=/magnet

RUN mkdir -p $WEDEPLOY_ELECTRIC_DIRECTORY
RUN mkdir -p $WEDEPLOY_MAGNET_DIRECTORY

# Install Java
ENV LANG=C.UTF-8

RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list
RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/openjdk.list
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/openjdk.list
RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update
RUN set -ex && \
    apt update -y && \
    apt install -t \
      jessie-backports \
      openjdk-8-jre-headless \
      ca-certificates-java -y

# Install Magnet
WORKDIR $WEDEPLOY_MAGNET_DIRECTORY

ADD ./magnet/package.json $WEDEPLOY_MAGNET_DIRECTORY
ADD ./magnet/package-lock.json $WEDEPLOY_MAGNET_DIRECTORY
RUN npm install --no-audit
ADD ./magnet $WEDEPLOY_MAGNET_DIRECTORY

# Install and run Electric
WORKDIR $WEDEPLOY_ELECTRIC_DIRECTORY

ADD ./electric/package.json $WEDEPLOY_ELECTRIC_DIRECTORY
ADD ./electric/package-lock.json $WEDEPLOY_ELECTRIC_DIRECTORY
RUN rm -rf ./electric/node_modules node_modules && npm install --no-audit
ADD ./electric $WEDEPLOY_ELECTRIC_DIRECTORY
RUN npm run build-prod
RUN mv $WEDEPLOY_ELECTRIC_DIRECTORY/dist $WEDEPLOY_MAGNET_DIRECTORY/electric

# Run Magnet
WORKDIR $WEDEPLOY_MAGNET_DIRECTORY
RUN npm run build && \
    npm run build:css

# Clean up
RUN apt-get purge --auto-remove \
      openjdk-8-jre-headless \
      ca-certificates-java -y

# Deployment Version
FROM node:8.16-stretch

ENV WEDEPLOY_MAGNET_DIRECTORY=/magnet

RUN mkdir -p $WEDEPLOY_MAGNET_DIRECTORY

WORKDIR $WEDEPLOY_MAGNET_DIRECTORY

COPY --from=builder $WEDEPLOY_MAGNET_DIRECTORY    .

EXPOSE 3001

CMD [ "npm", "start" ]
