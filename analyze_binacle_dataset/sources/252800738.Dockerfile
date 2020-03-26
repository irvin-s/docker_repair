FROM ubuntu:14.04  
MAINTAINER Carlos Moro <cmoro@deusto.es>  
  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  
  
# Create user  
RUN groupadd reveal  
RUN useradd reveal -m -g reveal -s /bin/bash  
RUN passwd -d -u reveal  
RUN echo "reveal ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/reveal  
RUN chmod 0440 /etc/sudoers.d/reveal  
RUN mkdir /home/reveal/presos  
RUN chown reveal:reveal /home/reveal/presos  
  
# Install node  
RUN apt-get -qqy update && \  
apt-get -qqy install git nodejs npm  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
WORKDIR /home/reveal/  
  
# Install reveal.js  
RUN git clone https://github.com/hakimel/reveal.js.git presos  
WORKDIR /home/reveal/presos  
RUN npm install -g grunt-cli  
RUN npm install  
RUN sed -i "s/port: port/port: port,\n\t\t\t\t\thostname: \'\'/g" Gruntfile.js  
  
WORKDIR /home/reveal/  
  
# Install wetty  
RUN git clone https://github.com/krishnasrinivas/wetty  
WORKDIR /home/reveal/wetty  
RUN npm install  
  
# Install bower  
RUN npm install -g bower  
  
# Install yeoman  
RUN npm install -g yo  
  
# Install reveal.js yeoman generator  
RUN npm install -g generator-reveal  
  
WORKDIR /home/reveal/presos  
  
VOLUME /home/reveal/presos  
  
EXPOSE 8000  
EXPOSE 9000  
USER reveal  
  
CMD [ "grunt", "serve" ]  

