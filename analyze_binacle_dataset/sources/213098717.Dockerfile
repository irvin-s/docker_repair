FROM mashape/kong:0.8.3

MAINTAINER Aaron Signorelli aaron@superpixel.com

RUN yum -y install nodejs npm
RUN npm install -g nodemon

CMD nodemon -L --watch /plugins --watch /etc/kong --ext lua,rockspec,yml --exec 'cd /plugins && luarocks make && kong reload'