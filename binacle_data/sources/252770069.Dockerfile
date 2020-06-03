FROM alpine:latest  
MAINTAINER Cris G c@cristhekid.com  
  
# Install required packages.  
RUN \  
apk add --update \  
git \  
python \  
&& rm -rf /var/cache/apk/*  
  
# Create Plexpy directory  
RUN mkdir -p /opt/plexpy  
  
# Clone the repo.  
RUN git clone https://github.com/Tautulli/Tautulli.git /opt/tautulli/  
  
# Volume for Plexpy data.  
VOLUME /data  
  
# Set the working directory.  
WORKDIR /opt/tautulli  
  
# Define default command.  
CMD ["python", "Tautulli.py", "--nolaunch", "--datadir=/data"]  
  
# Expose ports.  
EXPOSE 8181  

