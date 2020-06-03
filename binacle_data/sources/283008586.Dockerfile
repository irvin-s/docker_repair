# Melkweg runs on Python 2
FROM python:2

# Create app directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# Bundle app source
COPY . /usr/src/app

# Install dependencies
RUN build.sh

# Expose port
# Should be enough for Toni
EXPOSE 19985-20025

# Start tcp server by default 
CMD server.sh
# Alternatively, start kcp server
# CMD kcp_server.sh
