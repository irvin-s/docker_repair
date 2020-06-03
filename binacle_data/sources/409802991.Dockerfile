FROM ubuntu:12.04

MAINTAINER cpswan

# This copyrighted material is the property of
# Cohesive Flexible Technologies and is subject to the license
# terms of the product it is contained within, whether in text
# or compiled form.  It is licensed under the terms expressed
# in the accompanying README.md and LICENSE.md files.
#
# This program is AS IS and  WITHOUT ANY WARRANTY; without even
# the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.

# add universe repository to /etc/apt/sources.list
# we need it for rubygems
RUN sed -i s/main/'main universe'/ /etc/apt/sources.list

# make sure everything is up to date - update 
RUN apt-get update

# install rubygems, MySQL unzip
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rubygems libsqlite3-dev unzip

# install gems
RUN gem install sinatra sinatra-contrib data_mapper dm-sqlite-adapter --no-rdoc --no-ri

# copy and install sinatra-ToDoMVC application
ADD https://github.com/cpswan/sinatra-ToDoMVC/archive/sqlite.zip /opt/sinatra-ToDoMVC.zip
RUN cd /opt && unzip /opt/sinatra-ToDoMVC.zip

# default port for Sinatra is 4567
EXPOSE 4567

# run the ToDoMVC app
CMD /usr/bin/ruby /opt/sinatra-ToDoMVC-sqlite/app.rb

# example usage:
# sudo docker run -d -p 4567:4567 cohesiveft/todomvcdemo
