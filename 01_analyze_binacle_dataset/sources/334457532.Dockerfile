FROM openjdk:8-alpine as gitcloner

# apline allows to install software but slim doesn't.
# slim allows to compile specifically protobuf and alpine doesn't.
# In order to build need to install git and compile protobuf.
# Hence, gitcloner stage then builder stage.
# TODO: [rghetia] figure out better way to do this.

WORKDIR /app
RUN apk add --no-cache ca-certificates git curl unzip

RUN git clone https://github.com/census-instrumentation/opencensus-java.git 

# BUILDER
#########
FROM openjdk:8-slim as builder

WORKDIR /app
COPY --from=gitcloner /app .
RUN cd opencensus-java && ./gradlew install

# get the OpenCensus Version. Not the best way but it works.
RUN cd opencensus-java && \
    egrep CURRENT_OPENCENSUS_VERSION build.gradle | awk '{print $3}' | sed 's/^/export OCVERSION=/' > /app/.env 

# Used for caching downloads for rebuilding containers.
COPY ["build.gradle", "gradlew", "./"]
COPY gradle gradle
RUN sh -c ' cd /app/ ; . /app/.env; ./gradlew downloadRepos'

COPY . .
RUN sh -c ' cd /app/ ;  . /app/.env ; ./gradlew installDist' 

# APPLICATION CONTAINER
#######################
FROM openjdk:8-alpine

RUN apk add --no-cache libc6-compat curl

WORKDIR /app
COPY --from=builder /app .

EXPOSE 10101 10102 10103
ENTRYPOINT ["/app/build/install/javaservice/bin/javaservice"]
