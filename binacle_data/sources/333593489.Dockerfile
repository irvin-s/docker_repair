##
# Copyright IBM Corporation 2016, 2017
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
##

FROM ibmcom/swift-ubuntu:4.0.2
MAINTAINER IBM Swift Engineering at IBM Cloud
LABEL Description="Docker image for iOSCourseStore backend"

# Expose default port for Kitura
EXPOSE 8080

RUN mkdir /Backend

ADD Sources /Backend/Sources
ADD Package.swift /Backend
ADD Package.resolved /Backend
ADD LICENSE /Backend
ADD .swift-version /Backend
RUN cd /Backend && swift build -c release

#CMD ["/Backend/.build/debug/Backend"]
CMD [ "sh", "-c", "cd /Backend && .build/x86_64-unknown-linux/release/Backend" ]
