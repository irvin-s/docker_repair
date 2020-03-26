# Dockerfile for building (near-)minimal nginx
#


# pull base image
FROM ansible_mini_alpine3

MAINTAINER William Yeh <william.pjyeh@gmail.com>

#ENV APK_LIST  apk-list
#ENV PIP_LIST  pip-list

ENTRYPOINT ["/usr/sbin/nginx"]
#CMD ["-g", "daemon off;"]
CMD ["-v"]
