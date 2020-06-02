FROM openjdk:jre-alpine
MAINTAINER ?????

#### Image administration
# To build the image:
#   $ docker build -t familiar .
# To tag/release the image:
#   $ docker tag familiar YOUR-DOCKER-ID/familiar:1.2
#   $ docker push YOUR-DOCKER-ID/familiar:1.2

### Image usage in containers
# Start interactive shell:
#  $ docker run -it familiar:1.2
# mount host directory into the "host" directory inside the container:
#  $ docker run -v /path/to/local/directory:/familiar/host -it familiar
# Run a given script.fml located in PWD
#  $ docker run -v $PWD:/familiar/host familiar script.fml

RUN mkdir familiar familiar/host

WORKDIR familiar
COPY ./familiar.jar .
VOLUME ./host

WORKDIR ./host
ENTRYPOINT ["java", "-jar", "../familiar.jar"]
CMD []
