FROM centos:7  
LABEL maintainer "Benjamin Stein <info@diffus.org>"  
RUN rpm --import https://rex.linux-files.org/RPM-GPG-KEY-REXIFY-REPO.CENTOS6  
ADD rex.repo /etc/yum.repos.d/  
RUN yum makecache && \  
yum install -y \  
gcc \  
make \  
git \  
expat \  
expat-devel \  
curl \  
wget \  
which \  
net-tools \  
openssh \  
openssl \  
openssl-devel \  
ca-certificates \  
perl-DateTime \  
perl-File-Slurp \  
rex \  
cpanminus && \  
cpanm -n Array::Diff \  
Moose \  
MooseX::Params::Validate \  
namespace::autoclean \  
YAML \  
MIME::Base64 \  
JSON::XS \  
Import::Into \  
common::sense \  
Parallel::ForkManager \  
IPC::Lite Mojolicious \  
JSON::XS Crypt::OpenSSL::Random \  
Crypt::OpenSSL::RSA \  
LWP::UserAgent \  
LWP::Protocol::https && \  
yum clean all -y && \  
rm -rf .cpanm  
WORKDIR /root/rexfiles  

