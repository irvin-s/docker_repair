FROM bopen/ubuntu-pyenv:latest  
  
MAINTAINER Alessandro Amici <a.amici@bopen.eu>  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
python-software-properties \  
software-properties-common \  
&& add-apt-repository -s ppa:ubuntugis/ubuntugis-unstable \  
&& apt-get remove -y \  
python-software-properties \  
software-properties-common \  
&& apt-get autoremove -y \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

