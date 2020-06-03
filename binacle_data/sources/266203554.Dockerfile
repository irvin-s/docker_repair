FROM mhart/alpine-node:6

# Create app dir
RUN mkdir /app && cd /app

# Copy assets
COPY * /app/

# Install system deps
RUN apk update && apk add tmux vim

# Install node deps
RUN npm i nodemon -g

# Set workdir
WORKDIR /app

RUN ["chmod", "+x", "/app/start.sh"]

ENTRYPOINT "/app/start.sh"