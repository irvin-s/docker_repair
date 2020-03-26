FROM badele/debian-python3  
  
MAINTAINER Bruno Adelé "bruno@adele.im"  
# For the nmap tracker  
RUN apt-get update && apt-get install -y git  
  
# Install home-assitant from git repository  
RUN cd /opt && git clone https://github.com/balloob/home-assistant.git  
ADD files/requirements_all.txt /opt/home-assistant/requirements_all.txt  
RUN cd /opt/home-assistant && pip3 install -r requirements_all.txt  
  
# Install python executable  
RUN cd /opt/home-assistant && python3 setup.py develop  
  
# For the nmap tracker  
RUN apt-get install -y --no-install-recommends nmap net-tools  
  
# Clean the cache and unused packages  
RUN apt-get clean  
RUN apt-get autoremove  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Add sample configuration  
ADD files/configuration.yaml /opt/home-assistant/config/configuration.yaml  
  
CMD hass --config /opt/home-assistant/config/

