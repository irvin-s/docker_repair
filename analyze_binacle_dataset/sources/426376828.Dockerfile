#ifndef DOCKERFILE_ADD_APT_REPOSITORY
#define DOCKERFILE_ADD_APT_REPOSITORY

#// Adds the ability to call add-apt-repository.
#// Could add a check on /etc/lsb-release, and install accordingly.
#
#// On 12.04 and below, need to install: python-software-properties
#// On 12.10 and later, need to install: software-properties-common

RUN apt-get install -y python-software-properties software-properties-common

#endif // DOCKERFILE_ADD_APT_REPOSITORY