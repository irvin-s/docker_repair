# WSO2 MB 2.2.0  
# Pull base image.  
FROM damajor/dockerimgs:oracle-java7  
  
# Install Java.  
RUN \  
apt-get update && \  
apt-get install -y unzip wget  
  
# Fetch the wso2is package  
RUN wget --user-agent="fido" \  
\--output-document /opt/wso2mb.zip \  
\--referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" \  
http://product-dist.wso2.com/products/message-broker/2.2.0/wso2mb-2.2.0.zip  
  
# Clean up APT when done.  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Define working directory.  
#WORKDIR /data  
# Define commonly used JAVA_HOME variable  
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle  
  
RUN unzip /opt/wso2mb.zip -d /opt  
  
RUN rm -fr /opt/wso2mb.zip  
  
RUN \  
echo "export PATH=${JAVA_HOME}/bin:${PATH}" >> /etc/bash.bashrc  
  
EXPOSE 5672 8672  
# Define default command.  
CMD ["/opt/wso2mb-2.2.0/bin/wso2server.sh"]  

