FROM fedora:latest  
  
RUN dnf -y update && \  
dnf -y install sudo \  
which \  
git \  
ruby \  
ruby-devel \  
gcc \  
zlib-static \  
libpqxx-devel \  
openssl-devel \  
readline-devel \  
tar \  
patch \  
make \  
sqlite-devel \  
graphviz \  
postgresql-devel \  
gcc-c++ \  
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
  
RUN useradd -m -G wheel docker  
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
USER docker  
WORKDIR /home/docker  
  
CMD ["/bin/bash"]  

