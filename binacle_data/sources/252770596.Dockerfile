FROM centos:7  
  
MAINTAINER AeroGear Team <https://aerogear.org/>  
  
USER root  
  
#env vars  
ENV JAVA_HOME=/etc/alternatives/java_sdk_1.8.0 \  
ANDROID_HOME=/opt/android-sdk-linux \  
HOME=/root  
  
#tools folder  
COPY tools /opt/tools  
  
#system packages  
RUN yum install -y \  
openssl \  
openssl-devel \  
zlib.i686 \  
ncurses-libs.i686 \  
bzip2-libs.i686 \  
java-1.8.0-openjdk-devel \  
java-1.8.0-openjdk \  
ant \  
which\  
wget \  
expect \  
rsync  
  
#install dependencies and links androidctl cli to /usr/bin  
RUN curl https://bootstrap.pypa.io/get-pip.py | python && \  
pip install -U https://github.com/aerogear/androidctl/archive/0.1.0.zip && \  
mkdir -p ${ANDROID_HOME} && \  
chmod 775 -R /opt && \  
ln -s /opt/tools/androidctl-sync /usr/bin/androidctl-sync && \  
mkdir $HOME/.android && \  
chmod 775 $HOME/.android  
  
CMD ["sleep", "infinity"]  

