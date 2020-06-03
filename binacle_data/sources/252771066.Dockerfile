FROM centos  
  
ARG BUILD_DATE  
ARG VCS_REF  
  
ENV DUPLICITY_VERSION=0.7.13  
  
LABEL maintainer="Andre.Hilsendeger@gmail.com" \  
name="duplicity" \  
version=$DUPLICITY_VERSION \  
org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.name="duplicity" \  
org.label-schema.url="https://duplicity.nongnu.org" \  
org.label-schema.vcs-url="https://github.com/ahilsend/duplicity-docker.git" \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.schema-version="1.0.0" \  
org.label-schema.version=$DUPLICITY_VERSION  
  
COPY requirements.txt /requirements.txt  
  
RUN set -ex && \  
yum install -y epel-release && \  
yum update -y && \  
yum install -y \  
ca-certificates \  
gnupg \  
openssh \  
openssl \  
rsync \  
python-pip \  
gcc \  
python-devel \  
librsync \  
librsync-devel && \  
pip install --upgrade pip && \  
pip install -r /requirements.txt && \  
yum remove -y \  
python-pip \  
gcc \  
python-devel \  
librsync-devel && \  
yum clean all && \  
mkdir /root/.gnupg && \  
chmod 700 /root/.gnupg && \  
rm /requirements.txt  
  
CMD [ "duplicity" ]  

