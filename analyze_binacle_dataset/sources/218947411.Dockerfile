FROM debian:jessie

RUN apt-get update && apt-get install -y \
    s3cmd \
    --no-install-recommends

# Setup s3cmd config
RUN { \
    echo '[default]'; \
    echo 'access_key=$AWS_ACCESS_KEY'; \
    echo 'secret_key=$AWS_SECRET_KEY'; \
    } > ~/.s3cfg

WORKDIR /usr/src/birthdaysite/

# add files
COPY . /usr/src/birthdaysite/

ENTRYPOINT [ "./release.sh" ]
