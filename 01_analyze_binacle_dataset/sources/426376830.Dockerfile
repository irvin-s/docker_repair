#ifndef DOCKERFILE_BUILDBOT_COMMON
#define DOCKERFILE_BUILDBOT_COMMON

#include "Dockerfile.admin-user"
#include "Dockerfile.ssh"
#include "Dockerfile.git"

#// Refers to: https://github.com/mzdaniel/buildbot/commit/c5f243f3dfbcc74c5b538df4626e8000b6bcc2d9
#// Add the buildbot-slave packages.

RUN mkdir /home/buildbot
RUN apt-get install -y python-pip python-dev

#endif // DOCKERFILE_BUILDBOT_COMMON