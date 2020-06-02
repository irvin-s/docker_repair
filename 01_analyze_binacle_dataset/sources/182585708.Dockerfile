FROM ubuntu:wily
MAINTAINER Martin Høgh<mh@mapcentia.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get -y update --fix-missing
RUN apt-get -y install ghostscript phantomjs curl vim git supervisor postgresql-client

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN apt-get -y install nodejs

# Install grunt
RUN npm install -g grunt-cli

# Clone gc2conflict and html2pdf from GitHub
RUN cd  ~ &&\
	git clone http://github.com/mapcentia/gc2conflict.git &&\
	git clone http://github.com/mapcentia/html2pdf.it.git

# Install packages
RUN cd ~/gc2conflict &&\
	npm install

RUN cd ~/html2pdf.it &&\
	npm install

# Fix bug in jsts by locking javascript.utils to ver. 0.12.5
RUN sed -i 's/\~0\.12\.5/0\.12\.5/g' ~/gc2conflict/node_modules/jsts/package.json
RUN cd ~/gc2conflict &&\
	npm update

#Add config files from Git repo
RUN cp ~/gc2conflict/app/config/browserConfig.dist.js ~/gc2conflict/app/config/browserConfig.js &&\
	cp ~/gc2conflict/app/config/nodeConfig.dist.js ~/gc2conflict/app/config/nodeConfig.js &&\
	cp ~/gc2conflict/app/config/browserify.dist.js ~/gc2conflict/app/config/browserify.js


#Run Grunt
RUN cd ~/gc2conflict &&\
	grunt

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80

# Share the source dir
VOLUME  ["/root/gc2conflict"]

# Add Supervisor config and run the deamon
ADD conf/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]