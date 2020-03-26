FROM alpine:3.6  
MAINTAINER Simone La Placa <simone.laplaca@crweb.it>  
  
ENV HELM_VERSION v2.8.1  
ENV FILENAME helm-${HELM_VERSION}-linux-amd64.tar.gz  
  
RUN apk --no-cache add \  
bash \  
curl  
  
WORKDIR /  
  
ADD https://storage.googleapis.com/kubernetes-helm/${FILENAME} /tmp  
  
RUN tar -zxvf /tmp/${FILENAME} -C /tmp \  
&& mv /tmp/linux-amd64/helm /bin/helm \  
&& rm -rf /tmp  
  
RUN helm init --client-only  

