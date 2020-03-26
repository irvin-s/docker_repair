FROM bergwerkio/phoenix:1.0  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash  
RUN apt-get install -y -q inotify-tools nodejs  

