#
# Redis Dockerfile
#
# https://github.com/dockerfile/redis
#

# Pull base image.
#
# Just a stub. 

FROM 192.168.202.240:5000/lijiao/base-os:1.0
CMD env 1>/export/Data/env.log 2>&1 && sleep 1000000
