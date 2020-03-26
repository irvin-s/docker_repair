FROM google/cloud-sdk  
  
MAINTAINER Andreas Fritzler <andreas.fritzler@gmail.com>  
  
ENV VERSION v2.3.0  
ENV FILENAME helm-${VERSION}-linux-amd64.tar.gz  
  
WORKDIR /  
  
ADD https://kubernetes-helm.storage.googleapis.com/${FILENAME} /tmp  
  
RUN tar -zxvf /tmp/${FILENAME} -C /tmp \  
&& mv /tmp/linux-amd64/helm /bin/helm \  
&& rm -rf /tmp  

