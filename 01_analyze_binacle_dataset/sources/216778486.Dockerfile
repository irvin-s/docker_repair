FROM node:7.1.0
RUN mkdir -p /functional_test_suite
COPY package.json /functional_test_suite/package.json
WORKDIR /functional_test_suite
RUN npm install
