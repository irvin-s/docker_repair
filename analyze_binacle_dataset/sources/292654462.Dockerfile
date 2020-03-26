FROM node:8-alpine

# Create test directory
RUN mkdir -p /usr/src/test
WORKDIR /usr/src/test

# Bundle test folder
COPY . /usr/src/test

# Execute tests
ENTRYPOINT [ "npm", "run" ]
