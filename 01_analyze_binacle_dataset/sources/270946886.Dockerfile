ARG BUILD_FROM
FROM $BUILD_FROM

WORKDIR /usr/src/node-red

USER root
ENV LANG C.UTF-8
RUN apt-get update && \
    apt-get install -y jq && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Expose tcp/1880
EXPOSE 1880

# Environment variable holding file path for flows configuration
ENV FLOWS=flows.json
ENV NODE_PATH=/usr/src/node-red/node_modules:/share/node_modules:/data/node_modules

COPY settings.js /
COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
