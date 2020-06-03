FROM eeacms/kgs  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends build-essential \  
&& rm -vrf /var/lib/apt/lists/* \  
&& gosu plone buildout -c devel.cfg  

