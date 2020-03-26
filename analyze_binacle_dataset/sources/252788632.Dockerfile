FROM csmith/letsencrypt-generic:latest  
MAINTAINER Chris Smith <dke@chameth.com>  
  
RUN apt-get update \  
&& apt-get install -y \  
git \  
python3 \  
python3-pip  
  
RUN pip3 install \  
git+https://github.com/mydnshost/mydnshost-python-api.git  
  
ADD hook.sh /dns/hook  
RUN chmod +x /dns/hook  
  

