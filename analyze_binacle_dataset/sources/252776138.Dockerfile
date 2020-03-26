FROM alpine:3.7  
  
# Basic tools  
RUN apk add \--no-cache curl bash git tar sed  
  
# xsltproc and xmllint and xmlstarlet  
RUN apk add \--no-cache libxslt libxml2-utils xmlstarlet  
  
# JSON tools  
RUN apk add \--no-cache jq  
  
  

