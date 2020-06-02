# Set the base image to Ubuntu
FROM node:0.12.7

# File Author / Maintainer
MAINTAINER Ionut Lepadatescu

# Define working directory
WORKDIR /src

# this caches npm install
ADD ./package.json /src/package.json
RUN npm install --loglevel silent --production

# Insert this line before "RUN apt-get update" to dynamically
# replace httpredir.debian.org with a single working domain
# in attempt to "prevent" the "Error reading from server" error.
RUN sed -i "s/httpredir.debian.org/`curl -s -D - http://httpredir.debian.org/demo/debian/ | awk '/^Link:/ { print $2 }' | sed -e 's@<http://\(.*\)/debian/>;@\1@g'`/" /etc/apt/sources.list

# Install dependencies
# GraphicsMagick is required for image processing
# xlrd (excel reader) is required by node plugin "excel-parser"
RUN apt-get update && apt-get install -y GraphicsMagick && apt-get install -y python-pip && pip install -U xlrd

ADD ./server /src/server

# Expose port
EXPOSE  830
CMD ["node","/src/server/app.js"]
