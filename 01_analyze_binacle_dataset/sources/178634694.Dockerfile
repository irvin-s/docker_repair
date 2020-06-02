FROM debian:jessie
MAINTAINER Luigi Maselli http://grigio.org

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update && apt-get install -qq -y curl procps

ENV METEOR_RELEASE 1.0.3.1

# Install a specific Meteor release
RUN curl  https://install.meteor.com/ 2>/dev/null | sed 's/^RELEASE/#RELEASE/'| RELEASE=$METEOR_RELEASE sh

# Build scripts
ADD ./meteor-build.sh /
ADD ./meteor-run.sh /

ENV PORT 8080
EXPOSE   8080

WORKDIR /app
#ONBUILD RUN /meteor-build.sh

## Development
CMD meteor --release $METEOR_RELEASE --port $PORT

## Production
# Remember: docker run -e "MONGO_URL=mongodb://172.17.0.4:27017/mytest" -e "ROOT_URL=http://example.com" ...

# build + run 
# CMD sh /meteor-run.sh

