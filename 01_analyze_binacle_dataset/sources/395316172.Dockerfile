# Copyright (C) 2013-2014 Pivotal Software, Inc.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the under the Apache License,
# Version 2.0 (the "License”); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM centos:centos6

RUN echo root:changeme | chpasswd

# RUN mkdir -p /root/dcloud
# RUN echo -e '#!/bin/bash\nservice sshd start' > /root/dcloud/ssh_base.sh

# This yum install is repeated due to an issue where on some environment (originally found on Centos65/AWS) 
# Very first time yum install fails claiming mirrorlist.centos.org can not be found.
# https://jira.greenplum.com/browse/HDQA-104
RUN yum -y install vim || yum -y install vim

# ssh
RUN yum -y install openssh-server openssh-clients

# ssh "Connection to {host} closed" issue. https://gist.github.com/gasi/5691565
# This issue is still outstanding as of April 2014 (docker 0.9.1)
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# ssh login is slow. This is due to GSS authentication.
# e.g. debug1: Unspecified GSS failure.  Minor code may provide more information
# Referred this to improve.
# http://injustfiveminutes.com/2013/03/13/fixing-ssh-login-long-delay/
RUN sed -ri 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' /etc/ssh/sshd_config


# RUN yum -y install yum-cron


RUN echo 'NETWORKING=yes' > /etc/sysconfig/network

# Set up LANG
RUN echo -e 'LANG="en_US.UTF-8"\nSYSFONT="latarcyrheb-sun16"' >> /etc/sysconfig/i18n


