FROM ubuntu:trusty  
  
RUN apt-get update && \  
apt-get install -y software-properties-common && \  
add-apt-repository -y ppa:git-core/ppa && \  
apt-add-repository ppa:brightbox/ruby-ng && \  
apt-get update && \  
apt-get install -y \  
curl \  
wget \  
man-db \  
build-essential \  
git-core \  
libghc-zlib-dev \  
libssl-dev \  
python \  
libruby2.2 \  
ruby2.2 \  
ruby2.2-dev \  
postgresql \  
libpq-dev \  
sqlite3 \  
libsqlite3-dev \  
nodejs  
  
RUN gem install \  
bundler \  
rails \  
sqlite3 \  
sass \  
coffee-script \  
rspec \  
capybara \  
therubyracer \  
execjs \  
pg \  
rails_12factor \  
rails-erd  
  
RUN gem update  
  
RUN wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh  
  
RUN useradd -m -G sudo docker  
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
USER docker  
WORKDIR /home/docker  
  
CMD ["/bin/bash"]  

