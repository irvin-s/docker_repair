FROM ubuntu:artful  
MAINTAINER Chris Hardekopf <chrish@basis.com>  
  
# Install subversion and supporting packages (for hooks)  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y subversion \  
svnmailer msmtp msmtp-mta xinetd \  
python perl \  
pngcrush optipng advancecomp jpegoptim && \  
rm -rf /var/lib/apt/lists/*  
  
# Put sasl configuration in place, this expects to find the  
# sasl password stuff at /svn/svn.sasldb  
ADD svn.conf /usr/lib/sasl2/  
  
# Remove default msmtprc  
RUN rm -f /etc/msmtprc  
  
# Add the start script  
ADD start /opt/  
  
# Archives and configuration are stored in /svn  
VOLUME [ "/svn" ]  
  
# Expose public port for svnserve  
EXPOSE 3690  
# Run the svnserve server  
CMD [ "/opt/start" ]  

