FROM lachlanevenson/k8s-kubectl:latest  
MAINTAINER samuel.gratzl@datavisyn.io  
  
# install aws stuff  
RUN set -x \  
&& apk add --no-cache -v python py-pip less groff \  
&& pip install awscli \  
&& apk del --purge -v py-pip  
  
VOLUME /data  
ENTRYPOINT "/bin/sh"

