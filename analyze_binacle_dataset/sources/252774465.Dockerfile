FROM ubuntu:14.04  
MAINTAINER Alex Mozgovoy  
RUN apt-get update && apt-get dist-upgrade -y \  
&& apt-get install -y software-properties-common python-software-properties \  
&& add-apt-repository ppa:duplicity-team/ppa --yes \  
&& add-apt-repository ppa:chris-lea/python-boto --yes \  
&& apt-get update && apt-get install -y \  
python-boto duplicity && rm -rf /var/lib/apt/lists/*  
COPY duply /usr/local/bin/duply  
RUN chmod +x /usr/local/bin/duply  
ENTRYPOINT ["/usr/local/bin/duply"]  

