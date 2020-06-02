FROM alpine:3.7

MAINTAINER Sebastien Jodogne <s.jodogne@gmail.com>
LABEL Description="Atom-IT server" Vendor="Sebastien Jodogne, WSL S.A."

ADD ./build.sh /root/build.sh

# Install the build dependencies and compile Atom-IT in one single
# Docker layer, using the "group dependencies" feature to keep track
# of what to be uninstalled after compilation
RUN apk --update add --no-cache --virtual .build-dependencies \
                     g++ gcc cmake unzip tar git bash make e2fsprogs-dev python \
    && bash /root/build.sh "master" \
    && apk del .build-dependencies

# Make sure to have the C++ standard and UUID libraries available
RUN apk --update add --no-cache libstdc++ e2fsprogs

VOLUME [ "/var/lib/atomit/db" ]
EXPOSE 8042

ENTRYPOINT [ "AtomIT" ]
CMD [ "/etc/atomit/atomit.json" ]
