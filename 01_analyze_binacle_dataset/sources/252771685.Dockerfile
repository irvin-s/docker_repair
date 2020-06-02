FROM starefossen/ruby-node  
MAINTAINER Alex Ulianytskyi <a.ulyanitsky@gmail.com>  
  
# Packages  
ENV MAIN_PACKAGES git python python-pip  
ENV BUILD_DEPENDENCIES python-dev libgmp3-dev  
# Gems to install  
ENV DEFAULT_GEMS rails slack-notifier  
  
# Install main packages  
RUN apt-get update  
RUN apt-get install -yq ${MAIN_PACKAGES} ${BUILD_DEPENDENCIES}  
  
# AWS CLI & EB CLi  
RUN pip install --upgrade awscli awsebcli  
  
# Pre-install gems  
RUN gem install ${DEFAULT_GEMS}  
  
# Removing build dependencies, clean temporary files  
RUN apt-get purge -yq ${BUILD_DEPENDENCIES}  
  
# Make sure main packages installed  
RUN apt-get install -yq ${MAIN_PACKAGES}  
  
RUN apt-get autoremove -yq \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN ruby --version  
RUN node --version  
RUN python --version  
RUN aws --version  
RUN eb --version  
  
# throw errors if Gemfile has been modified since Gemfile.lock  
# RUN bundle config --global frozen 1  
RUN mkdir -p /usr/src/app  
  
WORKDIR /usr/src/app  
  
EXPOSE 3000  
CMD bin/start.sh  

