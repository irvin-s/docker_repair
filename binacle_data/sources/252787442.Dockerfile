FROM alpine:edge  
  
ENV HOME=/root \  
DIR=/home \  
SERVICE=unison  
  
RUN apk -U add unison bind-tools  
  
COPY loader /  
  
ENTRYPOINT [ "/loader" ]  
  

