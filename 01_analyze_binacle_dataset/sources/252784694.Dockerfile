FROM alpine:latest  
  
RUN apk add --no-cache py2-pip jq curl \  
&& pip install httpie \  
&& rm -r /root/.cache  
  
ENTRYPOINT [ "http" ]  
CMD [ "--help" ]  

