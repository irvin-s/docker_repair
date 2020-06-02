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
# Docker image for Virtual Device Service  
# FROM java:8  
FROM alpine:3.4  
MAINTAINER Cloud Tsai <Cloud.Tsai@Dell.com>  
  
RUN apk --update add openjdk8-jre  
  
# environment variables  
ENV APP_DIR=/edgex/edgex-device-virtual  
ENV APP=device-virtual.jar  
ENV APP_PORT=49990  
  
#copy JAR and property files to the image  
COPY *.jar $APP_DIR/$APP  
COPY *.properties $APP_DIR/  
COPY bacnet_sample_profiles $APP_DIR/bacnet_sample_profiles/  
COPY modbus_sample_profiles $APP_DIR/modbus_sample_profiles/  
  
#expose core data port  
EXPOSE $APP_PORT  
  
#set the working directory  
WORKDIR $APP_DIR  
  
#kick off the micro service  
ENTRYPOINT java -jar -Djava.security.egd=file:/dev/urandom -Xmx100M $APP

