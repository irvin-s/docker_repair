FROM python  
  
ADD . /tmp/deltw  
  
RUN set -e \  
&& ln -sf /bin/bash /bin/sh  
  
RUN set -e \  
&& apt-get -y update \  
&& apt-get -y upgrade \  
&& apt-get -y autoremove \  
&& apt-get clean  
  
RUN set -e \  
&& pip install -U --no-cache-dir pip /tmp/deltw \  
&& rm -rf /tmp/deltw  
  
ENTRYPOINT ["deltw"]  

