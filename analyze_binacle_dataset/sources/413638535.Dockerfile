FROM mysql:5.7

RUN apt-get update && apt-get -qq install -y --no-install-recommends memcached
