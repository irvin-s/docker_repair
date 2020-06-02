FROM ubuntu:14.04
MAINTAINER https://github.com/codeforseoul/FdAS
RUN apt-get update -qq
RUN apt-get install -qq -y curl
RUN apt-get install -qq -y python

# Housekeeping
RUN sed -i 's/archive.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list
RUN apt-get -qq update > /dev/null 2>&1

# "###### 1 Housekeeping - Install build tools and korean language pack ######"
RUN apt-get -qq install -y build-essential git-core language-pack-ko > /dev/null 2>&1
RUN apt-get -qq -y autoremove > /dev/null 2>&1

# "###### 1 Housekeeping - Set timezone to seoul ######"
RUN echo 'Asia/Seoul' | tee /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata > /dev/null 2>&1

# Install mongodb
# from http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
# "###### 2 Dependencies - mongodb ######"
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 > /dev/null 2>&1
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get -qq update > /dev/null 2>&1
RUN apt-get -qq -y install mongodb-org > /dev/null 2>&1

# Install nodejs
#echo "###### 2 Dependencies - nodejs ######"
RUN curl -sL https://deb.nodesource.com/setup | bash - > /dev/null 2>&1
RUN apt-get -qq -y install nodejs > /dev/null 2>&1

# Install node modules
# echo "###### 2 Dependencies - nodejs modules ######"
RUN npm install -g node-gyp strongloop grunt-cli bower > /dev/null 2>&1
WORKDIR /vagrant
COPY . /vagrant/
RUN npm install
RUN bower --allow-root install

# ready to run
RUN mkdir /root/src
WORKDIR /root/src
EXPOSE 3000
