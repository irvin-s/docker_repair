## PULL UBUNTU IMAGE WITH OPENJDK 8 SETUP
FROM tomcat:8-alpine
WORKDIR /usr/src/grassroot

# SETUP SUPERVISORD TO RUN JAVA AS A PROCESS + OTHER FANCY THINGS SUPERVISORD PROVIDES
RUN apk add --no-cache supervisor vim nano curl
COPY .deploy/supervisord.conf /etc/supervisord.conf

# DEFINE ENVIRONMENT VARIABLES
ENV GRADLE_USER_HOME=/usr/src/grassroot/.gradle

# SETUP ENVIRONMENT AND LOGS FOLDER THAT WILL BE SHARED WITH THE HOST
RUN mkdir -p /usr/src/grassroot/environment && mkdir -p /usr/src/grassroot/log && mkdir -p /usr/src/grassroot/templates/pdf

# COPY ALL SOURCE CODE, ALTERNATIVELY WE COULD BE COPYING JUST THE JAR FILES (TO REVIEW LATER)
COPY . /usr/src/grassroot

# BUT NO NEED TO BUILD IT AGAIN (ASSUMES FAT JAR WAS BUILT PRIOR)
# RUN /usr/src/grassroot/build-jar.sh

# START SUPERVISORD
CMD ["supervisord", "-n"]
