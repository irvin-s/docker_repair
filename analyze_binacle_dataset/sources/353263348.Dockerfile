FROM k0st/alpine-apache-php
MAINTAINER kost - https://github.com/kost

ENV VERSION_RIPS 0.55

RUN curl "http://sourceforge.net/projects/rips-scanner/files/rips-$VERSION_RIPS.zip/download" -L -o /tmp/rips-$VERSION_RIPS.zip && \
unzip /tmp/rips-$VERSION_RIPS.zip -d /app && \
rm /tmp/rips-$VERSION_RIPS.zip && \
mv /app/rips-$VERSION_RIPS/* /app/ && \
mkdir /work && \
echo "Success"

# already part of alpine-apache-php
#EXPOSE 80
# VOLUME /app
#WORKDIR /app
#ENTRYPOINT ["/scripts/run.sh"]

