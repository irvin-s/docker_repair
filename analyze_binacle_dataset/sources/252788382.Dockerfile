FROM debian:stable-slim  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
# Install ClamAV and components  
RUN apt-get update \  
&& apt-get upgrade -y \  
&& apt-get install -y \  
clamav \  
clamav-freshclam \  
clamav-daemon \  
&& rm -rf /var/lib/apt/lists/*  
  
# Create clamav folders  
RUN mkdir /var/run/clamav  
RUN chown clamav:clamav /var/run/clamav  
RUN chmod 750 /var/run/clamav  
  
# Copy config files for ClamAV and expose the port  
COPY conf /etc/clamav  
EXPOSE 3310  
# Run scripts  
ADD entrypoint.sh /  
RUN chmod +x /entrypoint.sh  
  
# Add initial set of definitions  
RUN freshclam  
  
CMD ["/entrypoint.sh"]  

