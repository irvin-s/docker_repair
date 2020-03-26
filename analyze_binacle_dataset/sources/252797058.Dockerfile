# CloudFleet Parachute client  
FROM debian:stretch  
LABEL "VERSION" "0.0.3"  
# Provisioning  
RUN export DEBIAN_FRONTEND='noninteractive' && \  
apt-get update && \  
apt-get install -y screen wget btrfs-tools rsync binutils gcc  
  
COPY . /opt/cloudfleet/apps/parachute  
WORKDIR /opt/cloudfleet/apps/parachute  
  
RUN setup/install-parachute.bash  
  
# Service definition  
CMD ["/bin/bash", "bin/start-parachute-client.bash"]  
  
  

