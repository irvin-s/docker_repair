FROM maven:3.3.9  
# Set the locale  
RUN apt-get clean && apt-get update && apt-get install -y locales  
RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \  
dpkg-reconfigure --frontend=noninteractive locales && \  
update-locale LANG=de_DE.UTF-8  
ENV LANG de_DE.UTF-8  

