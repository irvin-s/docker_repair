FROM alpine:3.3  
MAINTAINER Briefy <developers@briefy.co>  
  
# install python  
RUN apk add --no-cache python3 && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --upgrade pip setuptools moto&& \  
rm -r /root/.cache  
  
EXPOSE 5000  
ENTRYPOINT ["moto_server"]  
CMD ["--help"]  

