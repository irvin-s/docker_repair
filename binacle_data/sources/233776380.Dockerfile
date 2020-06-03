FROM node:latest

# Create app directory
RUN mkdir -p /mihome
WORKDIR /mihome

#install from local
COPY . /mihome

#Install from github
#RUN git clone https://github.com/TwanoO67/xiaomi-smart-home-gui.git .

RUN ./bin/install.sh

CMD [ "./bin/start.sh" ]
