FROM mrsheepuk/protractor  
  
RUN apt-get update && apt-get install -y procps \  
&& apt-get clean && rm -rf /var/lib/apt/lists/*  
  
RUN npm install -g ionic@2.1.18 \  
&& npm cache clean  
  
# Add service defintions for Xvfb, Selenium and Protractor runner  
ADD supervisord/*.conf /etc/supervisor/conf.d/

