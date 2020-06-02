FROM socrata/base

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install nodejs npm
# NPM has a hardcoded expired cert, so disable it
RUN npm set ca null
RUN npm install -g n
RUN n 6.9.1

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/nodejs=""
