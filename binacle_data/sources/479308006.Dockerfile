FROM mfellows/mono-api-base

MAINTAINER Matt Fellows <matt.fellows@onegeek.com.au>

ONBUILD WORKDIR /usr/src/app/build
CMD [ "echo", "built!" ]