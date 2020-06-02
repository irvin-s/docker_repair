FROM ubuntu  
RUN apt-get update && \  
apt-get install -y curl supervisor build-essential && \  
curl -sL https://deb.nodesource.com/setup_0.12 | sudo -E bash - && \  
sudo apt-get install -y nodejs && \  
USER=root npm install -g eslint node-inspector  
COPY supervisord.conf /etc/supervisord.conf  
RUN useradd -m node && mkdir -p /home/node/src  
COPY package.json /home/node/src/  
RUN chown -R node /home/node && \  
sudo -Hu node sh -c 'cd /home/node/src && npm install'  
COPY . /home/node/src/  
RUN chown -R node /home/node && \  
sudo -Hu node sh -c 'cd /home/node/src && npm run lint'  
CMD /usr/bin/supervisord -c /etc/supervisord.conf  
EXPOSE 8080  

