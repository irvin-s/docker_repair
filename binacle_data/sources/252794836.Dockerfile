FROM alpine:latest  
  
LABEL maintainer "David Becerril <david@davebv.com>"  
  
#RUN apk update && apk add ca-certificates && update-ca-certificates  
# Begin google cloud sdk install  
RUN apk add --update python bash openssl bind-tools  
RUN rm -rf /var/cache/apk/*  
  
WORKDIR /root  
  
ENV GVERSION 146.0.0  
ENV gcloud_sdk google-cloud-sdk-${GVERSION}-linux-x86_64.tar.gz  
  
ENV gcloud_addr https://dl.google.com/dl/cloudsdk/channels/rapid/downloads  
  
RUN wget ${gcloud_addr}/${gcloud_sdk}  
RUN tar -xvzf ${gcloud_sdk}  
RUN rm ${gcloud_sdk}  
  
RUN ./google-cloud-sdk/install.sh -q  
# End google cloud sdk install  
VOLUME /config  
  
ENV gdns_root /root/gdns  
  
WORKDIR ${gdns_root}  
ADD update.sh update.sh  
RUN chmod +x update.sh  
  
# Adds the template configuration  
ADD gdns.conf gdns.conf  
  
CMD ["/root/gdns/update.sh"]  
  

