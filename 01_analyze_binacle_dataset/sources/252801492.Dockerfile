FROM easeway/openvpn  
MAINTAINER EaseWay Hu <easeway@gmail.com>  
ADD ./server /opt/openvpn  
RUN apk update && \  
apk add py-pip jq gcc libc-dev python-dev && \  
pip install awscli && \  
apk del -r --purge gcc libc-dev python-dev && \  
rm -fr /var/cache/apk/* /tmp/* && \  
chmod a+rx /opt/openvpn/bin/*  
ENV HOME /  
ENTRYPOINT ["/opt/openvpn/bin/start-for-aws.sh"]  

