#ifndef DOCKERFILE_ADMIN_USER
#define DOCKERFILE_ADMIN_USER

#include "Dockerfile.sudo"

#define ADMIN_USERNAME admin
#define ADMIN_PASSWORD sa1aY64JOY94w

RUN useradd -m -d /home/admin -p ADMIN_PASSWORD ADMIN_USERNAME
RUN sed -Ei 's_adm:x:4:_admin:x:4:admin_' /etc/group
RUN sed -Ei 's_(\%admin ALL=\(ALL\) )ALL_\1 NOPASSWD:ALL_' /etc/sudoers

#endif // DOCKERFILE_ADMIN_USER