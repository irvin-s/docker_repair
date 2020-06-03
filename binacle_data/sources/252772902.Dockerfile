FROM node:stretch  
MAINTAINER Keith Berry "keithwberry@gmail.com"  
RUN apt-get update -y  
RUN apt-get install -y git  
RUN apt-get install -y neovim  
RUN apt-get install -y tmux  
  
RUN curl -sSL https://get.docker.com/ | sh  
  
ADD . /app  
WORKDIR /app  
RUN npm install  
  
RUN useradd -d /home/term -m -s /bin/bash term  
RUN echo 'term:term' | chpasswd  
  
EXPOSE 3000  
ENTRYPOINT ["node"]  
CMD ["app.js", "-p", "3000"]  

