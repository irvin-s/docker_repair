FROM ubuntu:trusty

# make it fresh
# add en UTF-8 as a locale
RUN DEBIAN_FRONTEND=noninteractive \
   && apt-get update \
   && apt-get -y install locales \
   && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen \
   && apt-get -y install wget \
\
   && wget -O - https://www.codeon.de/dists/codeon-pub.asc | apt-key add - \
   && echo "deb [arch=amd64] http://download.codeon.de `lsb_release -c -s` main" | tee /etc/apt/sources.list.d/codeon.de-main.list > /dev/null \
\
   && wget -O - https://www.mulle-kybernetik.com/dists/debian-admin-pub.asc | apt-key add - \
   && echo "deb [arch=all] http://www.mulle-kybernetik.com `lsb_release -c -s` main" | tee "/etc/apt/sources.list.d/mulle-kybernetik.com-main.list" > /dev/null \
\
   && echo "deb http://ppa.launchpad.net/george-edison55/cmake-3.x/ubuntu `lsb_release -c -s` main" | sudo tee "/etc/apt/sources.list.d/george-edison55-cmake-3_x-trusty.list" > /dev/null \
\
   && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 084ECFC5828AB726 \
   && apt-get update \
   && apt-get -y install mulle-objc-developer
