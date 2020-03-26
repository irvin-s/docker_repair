FROM dockerimages/ubuntu-core:14.04  
MAINTAINER Frank Lemanschik @ Direkt SPEED Europe <frank@dspeed.eu>  
ADD nave /usr/bin/nave  
# invalidate the Cache and update the apt list  
RUN echo currentsMillies > /created \  
&& apt-get -y update \  
&& apt-get -y upgrade \  
&& apt-get install -y curl wget git ca-certificates \  
&& chmod +x /usr/bin/nave \  
&& apt-get -y clean \  
&& nave install stable  
ENTRYPOINT ["nave", "use", "stable"]  
CMD ["npm"]  

