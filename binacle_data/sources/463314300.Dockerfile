#
# Copyright (c) 2017, 2018 Oracle and/or its affiliates. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM java:9

EXPOSE 8080
COPY ./* /
RUN rm Dockerfile
WORKDIR /
CMD if [ ! -z "$MIC_CONTAINER_MEM_QUOTA" ]; then java -Xmx${MIC_CONTAINER_MEM_QUOTA}m ${JAVA_OPTS}  -jar ${artifactId}-${version}-fat.jar  ; else  java ${JAVA_OPTS}  -jar ${artifactId}-${version}-fat.jar  ; fi
