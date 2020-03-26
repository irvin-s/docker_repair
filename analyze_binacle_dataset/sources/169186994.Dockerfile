FROM local/base

### PACKAGE MANAGER ###########################################################
###############################################################################

RUN apt-get update

### NODE ######################################################################
###############################################################################

# because of the well documented naming conflict with the
# Amateur Packet Radio Node Program use alternatives here
RUN apt-get install -y nodejs
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10
RUN apt-get install -y npm

# install modules globally
RUN npm install -g \
    commander \
    forever \
    grunt \
    mocha \
    nodemon \
    node-inspector \
    phantomjs \
    shelljs

### FOLDERS ###################################################################
###############################################################################

RUN mkdir -p /var/log
RUN mkdir -p /var/www

### VOLUMES ###################################################################
###############################################################################

VOLUME ["/var/www"]
VOLUME ["/var/log"]

### COMMAND ###################################################################
###############################################################################

# run node application (in legacy mode)
CMD cd /var/www && nodemon -L index.js