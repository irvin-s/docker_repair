FROM byllyfish/oftr:v0.40.0-alpine3.6  
  
ENV BUILDDEPS="git gcc python3-dev musl-dev"  
  
RUN set -ex \  
&& apk add --no-cache python3 $BUILDDEPS \  
&& python3 -m ensurepip \  
&& pip3 install git+https://github.com/byllyfish/zof.git \  
&& pip3 install git+https://github.com/byllyfish/faucet.git@port5 \  
&& rm -r /root/.cache \  
&& apk del $BUILDDEPS  
  
VOLUME ["/etc/ryu/faucet/", "/var/log/ryu/faucet/"]  
  
EXPOSE 6653 9302  
  
CMD ["python3", "-m","faucet.zof_faucet"]  

