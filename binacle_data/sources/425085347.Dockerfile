# MongoDB (gewo/mongodb)
FROM gewo/mongodb:3.0.5
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

# overwrite the mongodb-base start_mongodb
ADD start_mongodb /usr/local/bin/start_mongodb
RUN chmod 755 /usr/local/bin/start_mongodb
