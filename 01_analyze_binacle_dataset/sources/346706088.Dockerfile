#
# Redis Dockerfile
#
# https://github.com/dockerfile/redis
#

# Pull base image.
#
# Just a stub. 

FROM 192.168.202.240:5000/lijiao/example-1-redis:2.8.19

ADD run.sh /run.sh

CMD /run.sh
