# ------------------------------------------------------------------------
#
# Copyright 2016 WSO2, Inc. (http://wso2.com)
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
# limitations under the License

# ------------------------------------------------------------------------

FROM ubuntu:latest
MAINTAINER dev@wso2.org

RUN apt-get update \
    && apt-get install subversion apache2 libapache2-svn apache2-utils -y
RUN mkdir -p /svn/repos
COPY repo_template.conf /etc/apache2/sites-available/
COPY run_apache.sh /var/www/
RUN chmod 755 /var/www/run_apache.sh

EXPOSE 80

ENTRYPOINT ["/var/www/run_apache.sh"]