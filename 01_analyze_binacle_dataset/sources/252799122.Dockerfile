# Use this image as a base  
FROM niaquinto/gradle  
  
MAINTAINER "dewmal@egreen.io"  
# In case someone loses the Dockerfile  
RUN rm -rf /etc/Dockerfile  
ADD Dockerfile /etc/Dockerfile  
  
# Add your desired user and group  
#RUN groupadd mytrip  
#RUN useradd -s /bin/bash -m -d /usr/bin/app -g mytrip mytrip  
# Set your desired user as default  
#USER mytrip  
COPY . /usr/bin/app  
  
#RUN /usr/lib/gradle clean installC  
RUN mkdir /root/chitscanner  
  
EXPOSE 6464  
# Set your default behavior  
ENTRYPOINT ["gradle"]  
CMD ["-PmainClass=io.egreen.rbr.platform.Main", "platform:execute"]  

