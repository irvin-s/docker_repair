FROM bigm/nginx

RUN apt-get -yq --force-yes remove nginx-common

RUN /xt/tools/_apt_install build-essential debhelper make autoconf automake patch dpkg-dev fakeroot pbuilder gnupg dh-make libssl-dev libpcre3-dev git-core
