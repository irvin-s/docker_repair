FROM node:4.2.1  
# Install git  
RUN apt-get update  
RUN apt-get install -y git  
  
# Install arma dependencies  
RUN apt-get install -y lib32stdc++6  
  
# Cleanup apt files  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Create application folder  
RUN mkdir /app  
  
# Create application user  
RUN useradd -u 123 -U -s /bin/false arma && usermod -G users arma  
  
# Download Arma Server Web Manager  
RUN git clone https://github.com/Dahlgren/arma-server-web-admin.git /app  
  
# Install node dependencies for the application  
WORKDIR /app  
RUN npm install  
  
# Copy start application script  
COPY start.sh /app/  
  
# Start application  
CMD ./start.sh  
  
# Declare application port  
EXPOSE 3000  

