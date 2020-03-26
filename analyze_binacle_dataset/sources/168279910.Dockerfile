FROM        debian
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"
ENV REFRESHED_AT 2014-09-30

# Update the package repository
RUN apt-get update -qq && \ 
  apt-get upgrade -yqq

# Compiling and installing node.js
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq wget curl python g++ make checkinstall fakeroot && \
  apt-get -yqq clean && \
  src=$(mktemp -d) && cd $src && \
  wget -N http://nodejs.org/dist/node-latest.tar.gz && \
  tar xzvf node-latest.tar.gz && cd node-v* && \
  ./configure && \
  fakeroot checkinstall -y --install=no --pkgversion $(echo $(pwd) | sed -n -re's/.+node-v(.+)$/\1/p') make -j$(($(nproc)+1)) install && \
  dpkg -i node_*

# Installing possible node executers
RUN npm install -g nodemon forever

# Add node application into container
ADD src /var/www

# Install node dependences
RUN cd /var/www && npm install

# Expose application port
EXPOSE 8080

# Add docker start script
ADD start.sh /start.sh
CMD ["bash", "start.sh"]
