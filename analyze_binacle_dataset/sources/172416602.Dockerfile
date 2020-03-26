FROM node:4.4
MAINTAINER Jan Blaha
EXPOSE 5488

RUN apt-get update && apt-get install -y sudo
RUN npm install npm -g
RUN adduser --disabled-password --gecos "" jsreport
RUN echo "jsreport ALL=(root) NOPASSWD: /usr/local/bin/node" >> /etc/sudoers
RUN echo "jsreport ALL=(root) NOPASSWD: /usr/local/bin/npm" >> /etc/sudoers

VOLUME ["/jsreport"]

WORKDIR /home/jsreport

ADD run.sh /home/jsreport/run.sh

RUN sudo npm install jsreport --production
RUN sudo node node_modules/jsreport --init

RUN sudo npm install jsreport-ejs --production --save --save-exact
RUN sudo npm install jsreport-jade --production --save --save-exact
RUN sudo npm install jsreport-freeze --production --save --save-exact
RUN sudo npm install jsreport-phantom-image --production --save --save-exact

RUN sudo apt-get install -y xfonts-75dpi
RUN sudo apt-get install -y xfonts-base
RUN sudo wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-jessie-amd64.deb
RUN sudo dpkg -i wkhtmltox-0.12.2.1_linux-jessie-amd64.deb
RUN sudo npm install jsreport-wkhtmltopdf --production --save --save-exact

ENV NODE_ENV production

CMD ["bash", "/home/jsreport/run.sh"]

