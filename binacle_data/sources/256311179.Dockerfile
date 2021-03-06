# Copyright 2016 Teradata
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

FROM teradatalabs/centos6-java8-oracle:unlabelled
MAINTAINER Teradata Docker Team <docker@teradata.com>

# Setup CDH repo, pin the CDH distribution to a concrete version
RUN wget -nv http://archive.cloudera.com/cdh5/one-click-install/redhat/6/x86_64/cloudera-cdh-5-0.x86_64.rpm \
  && yum --nogpgcheck localinstall -y cloudera-cdh-5-0.x86_64.rpm \
  && rm cloudera-cdh-5-0.x86_64.rpm \
  && rpm --import http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera \
  && sed -i '/^baseurl=/c\baseurl=https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5.9.1/' /etc/yum.repos.d/cloudera-cdh5.repo \

# Install hive, as it's needed by all child images
  && yum install -y hive \

# Install supervisord
  && yum install -y python-setuptools \
  && easy_install pip \
  && pip install supervisor \
  && mkdir /etc/supervisord.d/ \
# ... and its missing dependency
  && wget -nv http://dl.fedoraproject.org/pub/epel/6/x86_64/python-meld3-0.6.7-1.el6.x86_64.rpm \
  && rpm -ihv python-meld3-0.6.7-1.el6.x86_64.rpm \
  && rm python-meld3-0.6.7-1.el6.x86_64.rpm \

# Cleanup
  && yum -y clean all && rm -rf /tmp/* /var/tmp/* \

# Alias log directories so that files in `/common` can use `/var/log/hadoop/*` format
  && mkdir -p /var/log/hadoop \
  && ln -s /var/log/hadoop-hdfs /var/log/hadoop/hdfs \
  && ln -s /var/log/hadoop-mapreduce /var/log/hadoop/mapreduce \
  && ln -s /var/log/hadoop-yarn /var/log/hadoop/yarn

# Copy supervisord startup script and base configs
COPY files/startup.sh /root/startup.sh
COPY files/supervisord.conf /etc/supervisord.conf
COPY files/supervisord.d/bootstrap.conf /etc/supervisord.d/bootstrap.conf
COPY files/change_timezone.sh /root/change_timezone.sh

# Add supervisord configs in child images
ONBUILD COPY files/supervisord.d/* /etc/supervisord.d/
