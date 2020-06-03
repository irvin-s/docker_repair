##########################################
#
##  Image Name: lithosphere/granite:mini
##  Git link: https://github.com/cloudegg-tech/lithosphere-docker/blob/master/lite/Dockerfile
##  Docker hub link: https://hub.docker.com/r/lithosphere/granite
##  Build docker image: docker build --no-cache -f Dockerfile -t lithosphere/granite:lite --rm=true .
#
##########################################
# Base Docker image: https://hub.docker.com/_/openjdk/
FROM clouthinkin/jre

LABEL maintainer ""

COPY container-files /

RUN mkdir -p /opt \
    && unzip /granite-lite-0.2.1.RELEASE.zip -d /opt \
    && rm /granite-lite-0.2.1.RELEASE.zip \
    && unzip /jce_policy-8.zip -d /tmp \
    && cp /tmp/UnlimitedJCEPolicyJDK8/local_policy.jar $JAVA_HOME/lib/security/ \
    && cp /tmp/UnlimitedJCEPolicyJDK8/US_export_policy.jar $JAVA_HOME/lib/security/ \
    && rm /jce_policy-8.zip

RUN chmod +x /*.sh

EXPOSE 5222

WORKDIR /

ENTRYPOINT /docker-entrypoint.sh
