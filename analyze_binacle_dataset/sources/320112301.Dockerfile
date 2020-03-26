# Dockerfile represents the container being use to run the driver, should be
# small as possible containing strictly only the tools required to run the
# driver.

# The prefered base image is the lastest stable Alpine image, if alpine doesn't
# meet the requirements you can switch the from to the latest stable slim
# version of Debian (eg.: `debian:jessie-slim`). If the excution environment
# is equals to the build environment the build image can be use as FROM:
#   bblfsh/<language>-driver-build
FROM alpine:3.6

RUN apk add --no-cache nodejs="6.10.3-r1"

ADD build /opt/driver
ENTRYPOINT /opt/driver/bin/driver
