FROM debian:jessie  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Update and install packages  
RUN apt-get update \  
&& apt-get install -y curl git wget php5-cli php5-curl sudo vim  
  
RUN useradd -d /home/behat -m -s /bin/bash behat  
  
# Add "behat" to "sudoers"  
RUN echo "behat ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/90-behat  
  
ENV HOME /home/behat  
WORKDIR $HOME  
RUN mkdir $HOME/bin $HOME/composer $HOME/data  
  
# Add file into docker container  
ADD conf/composer.json $HOME/composer/composer.json  
  
# Install Behat and Drupal extension  
RUN cd $HOME/composer && curl http://getcomposer.org/installer | php \  
&& php composer.phar install --prefer-dist  
  
ENV PATH $PATH:/home/behat/composer/bin  
  
# Fix permissions  
RUN chown -R behat:behat /home/behat  
  
# Disable strict checking  
RUN echo ' StrictHostKeyChecking no' >> /etc/ssh/ssh_config  
  
WORKDIR /home/behat/data  
USER behat  
  
CMD true  
#CMD ["/bin/bash", "while", "true", "FOREGROUND"]  

