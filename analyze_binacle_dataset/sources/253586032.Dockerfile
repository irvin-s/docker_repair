# this image compress js and output tar.gz of project
#
FROM node

RUN mkdir -p /tmp/build
ADD ./ /tmp/build/
WORKDIR /tmp/build
RUN ./ci/build-dist.sh
CMD tar -czf - .
