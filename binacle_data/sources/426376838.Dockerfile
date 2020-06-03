#ifndef DOCKERFILE_SUPERVISORD
#define DOCKERFILE_SUPERVISORD

#// Install supervisord.

RUN apt-get install -y supervisor

#// If supervisord was included after Dockerfile.admin-user
#// Then configure supervisord to use the admin user credentials.
#//
#// NOTE: This is probably a bad idea, as a number of servers
#//       use privileged ports under 1024 (SSH, for example)

#// #ifdef DOCKERFILE_ADMIN_USER
#// RUN /bin/echo -e "[supervisord] \nuser=admin" > /etc/supervisord.conf
#// #endif

#endif // DOCKERFILE_SUPERVISORD