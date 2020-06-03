FROM node:8-alpine

# Handle env variable
ARG TEST_HOST
ENV TEST_HOST $TEST_HOST

# Create test directory
RUN mkdir -p /test/
WORKDIR /test/

# Bundle test and depencencies
COPY package.json ./
COPY doc ./doc/
COPY node_modules ./node_modules/
COPY test/integration ./test/integration/

# Execute tests
CMD [ "npm", "run", "test:integration" ]
