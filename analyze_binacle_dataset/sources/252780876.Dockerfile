FROM alpine  
  
MAINTAINER Coroin LLC <info@coroin.com>  
  
RUN apk --no-cache add ansible \  
&& rm -rf /var/lib/apt/lists/* \  
&& rm -rf /var/cache/apk/* \  
&& apk info -v | sort  
  
VOLUME /project  
  
WORKDIR /project  
  
ENTRYPOINT ["ansible-playbook"]  

