FROM gliderlabs/logspout:master

MAINTAINER Pavel Vanecek <pavel.vanecek@merck.com>

# This Dockerfile is intentionally empty
# The parent image already has ONBUILD directives that will copy the `modules.go` file and build.
# You can verify this by running docker inspect:

# docker inspect --format "{{.ContainerConfig.OnBuild}}" gliderlabs/logspout:master
# > [COPY ./modules.go /src/modules.go RUN cd /src && ./build.sh "$(cat VERSION)-custom"]

# if the output is empty array "[]" you do not have the right image.
