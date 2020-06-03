###############################################################################
# Copyright 2016-2017 Dell Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
###############################################################################
FROM maven:3.3-jdk-8-alpine

COPY docker-files/pom.xml .

RUN mvn dependency:copy -q

FROM alpine:3.6
MAINTAINER Jim White <james_white2@dell.com>

RUN apk --update add openjdk8-jre

# environment variables
ENV APP_DIR=/edgex/edgex-device-mqtt
ENV APP=device-mqtt.jar
ENV APP_PORT=49982

#copy JAR and property files to the image
COPY --from=0 *.jar $APP_DIR/$APP
COPY docker-files/*.properties $APP_DIR/
#copy Device YML to the image
COPY *.yml $APP_DIR/

#expose core data port
EXPOSE $APP_PORT

#set the working directory
WORKDIR $APP_DIR

#kick off the micro service
ENTRYPOINT java -jar -Djava.security.egd=file:/dev/urandom -Xmx100M $APP
