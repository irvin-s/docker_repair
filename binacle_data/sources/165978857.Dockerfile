FROM ubuntu:18.04
MAINTAINER Jesse Whitham "jesse.whitham@gmail.com"

#INSTALL necessary packages for install 
#NB: -y flag assumes yes when apt asks if you want to install the other packages needed
RUN apt-get update && apt-get install -y sudo curl build-essential libxml2-dev libxslt-dev git screen && rm -rf /var/lib/apt/lists/*

#INSTALL chef (for nexpose cookbook install)
RUN curl -L https://www.opscode.com/chef/install.sh | sudo bash

#INSTALL berkshelf gem (used to install cookbooks)
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN /opt/chef/embedded/bin/gem install berkshelf

#COPY local dir into chef folder on container (could exclude the Dockerfile or just be more implicit here)
ADD . /chef

#DOWNLOAD nexpose cookbook (out of Berksfile from copy)
RUN cd /chef && /opt/chef/embedded/bin/berks vendor /chef/cookbooks

#SET file permissions of screen folder (to fix weird behaviour by chef)
RUN chmod 777 /var/run/screen

#INSTALL nexpose cookbook
RUN chef-solo -c /chef/file_paths.rb -j /chef/run_list.json

#EXPOSE nexpose web console
EXPOSE 3780

#CHANGE directory (nexpose throws an error unless you are in the right directory)
#START nexpose console (this takes ages needs to build updates etc.)
#PIPE the output to dev/null (otherwise will fill the logs)
CMD cd /opt/rapid7/nexpose/nsc/ && ./nsc.sh  > /dev/null
