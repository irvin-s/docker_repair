# Copyright 2017 Red Hat  
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
# ------------------------------------------------------------------------  
#  
# This is a Dockerfile for the oshinko-webui-openshift:0.4.3 image.  
FROM nodesource/centos7:6.3.1  
  
# Environment variables  
ENV JBOSS_IMAGE_NAME="oshinko-webui-openshift" \  
JBOSS_IMAGE_VERSION="0.4.3"  
# Labels  
LABEL name="$JBOSS_IMAGE_NAME" \  
version="$JBOSS_IMAGE_VERSION" \  
architecture="x86_64" \  
com.redhat.component="oshinko-webui-openshift"  
# Exposed ports  
EXPOSE 8080  
  
USER root  
  
  
# Install required RPMs and ensure that the packages were installed  
RUN yum install -y wget git bzip2 \  
&& yum clean all && \  
rpm -q wget git bzip2  
  
# Add all artifacts to the /tmp/artifacts  
# directory  
COPY \  
openshift-origin-client-tools-v3.7.0-7ed6862-linux-64bit.tar.gz \  
/tmp/artifacts/  
  
# Add scripts used to configure the image  
COPY modules /tmp/scripts  
  
# Custom scripts  
USER root  
RUN [ "bash", "-x", "/tmp/scripts/npm_bower/install" ]  
  
USER root  
RUN [ "bash", "-x", "/tmp/scripts/launch/install" ]  
  
USER root  
RUN [ "bash", "-x", "/tmp/scripts/oc/install" ]  
  
USER root  
RUN [ "bash", "-x", "/tmp/scripts/app/install" ]  
  
USER root  
RUN [ "bash", "-x", "/tmp/scripts/chown/install" ]  
  
USER root  
RUN rm -rf /tmp/scripts  
USER root  
RUN rm -rf /tmp/artifacts  
  
USER root  
  
# Specify the working directory  
WORKDIR /usr/src/app  
  
  
CMD ["/usr/src/app/launch.sh"]  

