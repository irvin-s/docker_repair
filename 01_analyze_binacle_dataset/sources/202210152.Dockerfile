FROM astronomerio/aries-data
MAINTAINER astronomer <greg@astronomer.io>

ONBUILD WORKDIR /usr/local/src

# copy package.json and install modules
ONBUILD COPY package.json .
ONBUILD RUN ["npm", "install"]

# Add standard files on downstream builds.
# Add lib and test last to use docker layer caching for previous layers
# especially npm install. Avoids downstream images needing to run npm install
# on every change to lib or test files
ONBUILD COPY .babelrc .
ONBUILD COPY .eslintrc .
ONBUILD COPY lib lib
ONBUILD COPY test test
