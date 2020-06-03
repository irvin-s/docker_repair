# Pull base image.  
FROM mhart/alpine-node:4.4.4  
# Set default server environment variables  
# ROLE ( CLIENT or SERVER )  
ENV ROLE 'CLIENT'  
# The deepstream urls to connect too (Comma Seperated)  
ENV DEEPSTREAMS localhost:6021  
# Total amount of client pairs to load  
ENV CLIENT_PAIRS 150  
# How often messages should be sent  
ENV MESSAGE_FREQUENCY 20  
# Max amount of messages per client  
ENV MESSAGE_LIMIT 10000  
# The client spawning speed  
ENV SPAWNING_SPEED 100  
# LOG LATENCY  
ENV LATENCY true  
  
# Run server for 10 minutes  
ENV TEST_TIME 10000  
# TCP Port  
ENV TCP_PORT 6021  
# EngineIO Port ( Tests do not use yet )  
ENV PORT 6020  
# REDIS HOST  
ENV REDIS_HOST 'localhost'  
# REDIS PORT  
ENV REDIS_HOST 6379  
# Set S3 variables  
ENV S3_ENABLED true  
ENV S3_BUCKET 'ds-performance-results'  
ENV TEST_ID 'first-ever-test'  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Copy src script  
COPY . /usr/src/app  
  
# Define default command.  
CMD [ "node", "./src/start" ]

