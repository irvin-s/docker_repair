FROM ubuntu:16.04  
RUN apt-get update -y  
  
RUN apt-get install -y build-essential clang libdbus-1-dev libgtk2.0-dev \  
libnotify-dev libgnome-keyring-dev libgconf2-dev \  
libasound2-dev libcap-dev libcups2-dev libxtst-dev \  
libxss1 libnss3-dev gcc-multilib g++-multilib curl \  
gperf bison wget  
  
RUN wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz  
RUN tar -xzf postman.tar.gz -C /opt  
RUN rm postman.tar.gz  
RUN ln -s /opt/Postman/Postman /usr/bin/postman

