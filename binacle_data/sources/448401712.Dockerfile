FROM ubuntu:14.04
MAINTAINER Valerio Schiavoni <valerio.schiavoni@gmail.com>
RUN apt-get update && apt-get install -y git gnupg2 curl build-essential mysql-client-5.5 mysql-server libmysqlclient-dev libssl-dev libxslt-dev libxml2-dev
#RUN useradd -ms /bin/bash splay
#USER splay
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm install ruby-1.8.7-p374"
RUN /bin/bash -l -c "gem install dbi mysql json dbd-mysql openssl-nonblock algorithms geoip"
RUN /bin/bash -l -c "gem install net-ping -v 1.6.0"
RUN /bin/bash -l -c "gem install nokogiri -v 1.5.11"
RUN git clone https://github.com/splay-project/splay.git #replace with splay-controller repository when available
RUN cd splay/src/controller
RUN ruby -rubygems init_db.rb
RUN ruby -rubygems init_users.rb
RUN ruby -rubygems controller_fork.rb
