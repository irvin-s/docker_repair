# Mocha Test Runner for API test suite
# See : https://dzone.com/articles/testing-nodejs-application-using-mocha-and-docker

FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-aggregator-service

# Copy the test files
COPY node-aggregator-service/test test

# Override the NODE_ENV environment variable to 'dev', in order to get required test packages
ENV NODE_ENV dev

# 1. Get test packages; AND
# 2. Install our test framework - mocha
RUN yarn && \
    yarn global add mocha

# Run the tests instead of the application
CMD ["yarn", "test"]
