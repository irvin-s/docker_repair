# Copyright 2016 The Kubernetes Authors All rights reserved.  
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
# A Dockerfile for creating an Elasticsearch instance that is designed  
# to work with Kubernetes logging. Inspired by the Dockerfile  
# dockerfile/elasticsearch  
FROM elasticsearch:2.4.1  
MAINTAINER Satnam Singh "satnam@google.com"  
MAINTAINER Pan Luo "pan.luo@ubc.ca"  
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml  
COPY run.sh /  
COPY elasticsearch_logging_discovery /  
  
VOLUME /data  
EXPOSE 9200 9300  
ENTRYPOINT ["/run.sh"]  
CMD ["elasticsearch"]  

