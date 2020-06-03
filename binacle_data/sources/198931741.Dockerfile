# install packages
FROM ubuntu
RUN apt-get update

# install some packages
RUN apt-get install -y build-essential
RUN apt-get install -y supervisor
RUN apt-get install -y git
RUN apt-get install -y imagemagick
RUN apt-get install -y libicu-dev libfontconfig1-dev libjpeg-dev libfreetype6

# install node
RUN apt-get install sudo
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs

# copy app from local repository into container
ADD assets /var/app/current/assets
ADD client /var/app/current/client
ADD common /var/app/current/common
ADD docker-assets/webapp /var/app/current/docker-assets/webapp
ADD server /var/app/current/server
ADD tests /var/app/current/tests
# ADD working /var/app/current/working
ADD locales /var/app/current/locales
ADD gruntfile.js /var/app/current/gruntfile.js
ADD package.json /var/app/current/package.json

RUN mkdir /var/app/current/working

# set up supervisord
RUN cd /var/app/current; cp docker-assets/webapp/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# To run npm install or not to run npm install, that is the question.
#
# in this case it is not needed so just copy the entire node_modules
# directory to the container so it exactly matches the development
# environment
#
ADD node_modules /var/app/current/node_modules

# If there were os specific npm modules we could run npm install
# but that comes with some thorny issues - you could get different
# versions of packages running inside the container than are
# running in your development environment. This is an issue to
# consider when controlling you continuous deployment strategy.
# Where possible I like npm updates to be a function of the development
# environment keeping deployment out of module version hell.
#
# RUN cd /var/app/current; npm install

RUN cd /var/app/current; npm install phantomjs-prebuilt

# expose webapp port
EXPOSE 3000

WORKDIR "/var/app/current"

CMD ["/usr/bin/supervisord"]
