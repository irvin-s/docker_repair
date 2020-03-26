FROM alpine:edge  
  
MAINTAINER Chuanjian Wang <chuanjian@staff.sina.com.cn>  
  
COPY bundles/spond /bin/spond  
COPY bundles/sponctl /bin/sponctl  
  
EXPOSE 8080  

