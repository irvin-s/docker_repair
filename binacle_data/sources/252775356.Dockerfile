FROM alpine:3.3  
MAINTAINER BehanceRE <qa-behance@adobe.com>  
  
WORKDIR "/data"  
  
RUN apk update && \  
apk add \  
bash \  
'python<3.0' \  
'py-pip<8.2' \  
&& \  
rm -rf /var/cache/apk/*  
  
RUN pip install awscli  
  
ADD download-s3-files /opt/behance/download-s3-files  
  
ENTRYPOINT ["/bin/bash", "/opt/behance/download-s3-files"]  
CMD []  

