# Copyright 2017 Red Hat
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
# ------------------------------------------------------------------------
#
# This is a Dockerfile for the radanalyticsio/radanalytics-pyspark:1.0 image.

FROM centos/python-27-centos7:latest

USER root


# Install required RPMs and ensure that the packages were installed
RUN yum install -y java-1.8.0-openjdk \
    && yum clean all && rm -rf /var/cache/yum \
    && rpm -q java-1.8.0-openjdk


# Add all artifacts to the /tmp/artifacts
# directory
COPY \
    spark-2.4.0-bin-hadoop2.7.tgz \
    oshinko_v0.6.1_linux_amd64.tar.gz \
    /tmp/artifacts/


# Environment variables
ENV \
    APP_LANG="python" \
    APP_ROOT="/opt/app-root" \
    JBOSS_IMAGE_NAME="radanalyticsio/radanalytics-pyspark" \
    JBOSS_IMAGE_VERSION="1.0" \
    PATH="/opt/app-root/src/.local/bin/:/opt/app-root/src/bin:/opt/app-root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/spark/bin" \
    PYTHONPATH="/opt/spark/python" \
    RADANALYTICS_PYSPARK="1.0" \
    SPARK_HOME="/opt/spark" \
    SPARK_INSTALL="/opt/spark-distro" 

# Labels
LABEL \
      io.cekit.version="2.2.7"  \
      io.k8s.description="Platform for building a radanalytics Python 2.7 pyspark app"  \
      io.k8s.display-name="radanalytics pyspark"  \
      io.openshift.expose-services="8080:http"  \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"  \
      io.openshift.tags="builder,radanalytics,pyspark"  \
      io.radanalytics.sparkdistro="https://archive.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz"  \
      name="radanalyticsio/radanalytics-pyspark"  \
      org.concrt.version="2.2.7"  \
      version="1.0" 

# Add scripts used to configure the image
COPY modules /tmp/scripts

# Custom scripts
USER root
RUN [ "bash", "-x", "/tmp/scripts/common/install" ]

USER root
RUN [ "bash", "-x", "/tmp/scripts/spark/install" ]

USER root
RUN [ "bash", "-x", "/tmp/scripts/pyspark/install" ]

USER root
RUN rm -rf /tmp/scripts
USER root
RUN rm -rf /tmp/artifacts

USER 185


ENTRYPOINT ["/opt/app-root/etc/bootstrap.sh"]

CMD ["/usr/libexec/s2i/usage"]

