FROM centos:7  
LABEL maintainer "DI GREGORIO Nicolas <ndigregorio@ndg-consulting.tech>"  
  
### Environment variables  
ENV LANG='en_US.UTF-8' \  
LANGUAGE='en_US.UTF-8' \  
TERM='xterm'  
  
### Install Application  
RUN yum install -y epel-release && \  
yum upgrade -y && \  
yum install -y \  
ca-certificates \  
openssl \  
ssmtp \  
mailx \  
perl \  
perl-IO-Socket-SSL \  
perl-IO-Socket-INET6 \  
perl-NetAddr-IP \  
perl-Data-Dumper \  
perl-Test-Simple \  
perl-Test-Requires \  
&& \  
yum install -y \  
make \  
gcc \  
perl-devel \  
libxml2-devel \  
openssl-devel \  
wget \  
git \  
expat-devel \  
&& \  
wget https://cpanmin.us/ -O /usr/local/bin/cpanm && \  
chmod +x /usr/local/bin/cpanm && \  
cpanm Data::Validate::IP && \  
git clone --depth 1 https://github.com/wimpunk/ddclient /opt/ddclient && \  
git clone --depth 1 https://github.com/ncopa/su-exec /tmp/su-exec && \  
cd /tmp/su-exec && \  
make && \  
cp /tmp/su-exec/su-exec /usr/local/bin/su-exec && \  
yum history -y undo last && \  
yum clean all && \  
rm -rf /opt/ddclient/.git \  
/usr/local/bin/cpanm \  
/root/.cpan \  
/tmp/* \  
/var/cache/yum/* \  
/var/tmp/*  
  
### Volume  
  
### Expose ports  
  
### Running User: not used, managed by docker-entrypoint.sh  
USER root  
  
### Start ddclient  
COPY ./docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["ddclient"]  

