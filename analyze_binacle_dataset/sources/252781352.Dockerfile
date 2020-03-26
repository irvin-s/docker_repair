FROM ruby:2.5.0  
ENV APP_HOME /app  
RUN mkdir $APP_HOME  
WORKDIR $APP_HOME  
ADD Gemfile* $APP_HOME/  
  
#upgrade ubuntu  
RUN apt-get update  
RUN apt-get install -y apt-utils whiptail build-essential  
  
#set locale en_US.UTF-8  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales && \  
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \  
dpkg-reconfigure --frontend=noninteractive locales && \  
update-locale LANG=en_US.UTF-8  
ENV LANG en_US.UTF-8  
# postgres prerequisites  
RUN apt-get install -y libpq-dev  
  
# nokogiri prerequisites  
RUN apt-get install -y libxml2-dev libxslt1-dev  
  
# capybara-webkit prerequisites  
RUN apt-get install -y libqtwebkit4 libqt4-dev xvfb  
  
# node.js prerequisites  
RUN apt-get install -y python python-dev python-pip python-virtualenv  
  
# install latest nodejs9.X  
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -  
RUN apt-get install -y nodejs  
  
# install node packages  
RUN npm install -g bower  
RUN npm install -g phantomjs --unsafe-perm  
RUN npm install -g yarn  
  
# cleanup  
RUN rm -rf /var/lib/apt/lists/*  
  
#install gem file  
RUN bundle install  
RUN rm -rf Gemfile*  
  
ONBUILD ADD . $APP_HOME  
  
CMD ["bash"]  

