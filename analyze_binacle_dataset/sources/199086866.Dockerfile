# docker build . -t docker-man-pages-osx:latest
FROM savant/md2man
LABEL maintainer Chris Mosetick <cmosetick@gmail.com>
RUN \
apk add --update --no-cache bash && \
rm -rf /var/cache/apk/* && \
ln -s /bin/md2man /bin/go-md2man
