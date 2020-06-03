FROM baselibrary/ruby:2.2  
MAINTAINER ShawnMa <qsma@thoughtworks.com>  
  
## Version  
ENV KUBERNETES_MAJOR 1.1  
ENV KUBERNETES_RELEASE 1.1.2  
## Packages  
RUN \  
apt-get update &&\  
apt-get install -y supervisor &&\  
rm -rf /var/lib/apt/lists/*  
RUN \  
gem install tiller  
ADD etcd /usr/bin/  
ADD etcdctl /usr/bin/  
ADD km /usr/bin/  
ADD kubectl /usr/bin/  
  
## Configurations  
ADD config /etc/tiller  
  
VOLUME ["/var/lib/kubernetes"]  
  
CMD ["/usr/local/bin/tiller" , "-v"]  
  

