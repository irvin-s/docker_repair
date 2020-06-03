FROM phusion/baseimage:0.9.18

EXPOSE 111 2049 60934 43440 55392 53559 875

CMD ["/sbin/my_init"]

# The enormous RUN block is needed to reduce resulting container size
# as it prevents docker from snapshotting container before all unneeded
# packages are removed. It is made by combining several separate steps:
# setting up necessary packages, compiling and setting up ganesha,
# setting up samba and removing unneeded packages.
RUN apt-get update && apt-get install -y \
      bison \
      build-essential \
      cmake \
      dbus \
      doxygen \
      flex \
      git-core \
      libcephfs-dev \
      libdbus-1-dev \
      libgssglue-dev \
      libkrb5-dev \
      libtirpc1 \
      libssl-dev \
      nfs-common \
      pkg-config \
      portmap \
      python-dbus \
      samba \
      smbclient \
      uuid-dev &&\
    mkdir -p /shares &&\
    chmod 0777 /shares &&\
    mkdir -pv /var/run/dbus &&\
    cd /usr/src &&\
    git clone https://github.com/nfs-ganesha/nfs-ganesha.git &&\
    cd nfs-ganesha &&\
    git checkout -b V2.3-stable origin/V2.3-stable &&\
    git submodule update --init &&\
    mkdir -p build &&\
    cd build &&\
    cmake -DUSE_DBUS=ON -DUSE_FSAL_LUSTRE=OFF ../src &&\
    make &&\
    make install &&\
    make clean &&\
    cp /usr/src/nfs-ganesha/src/scripts/ganeshactl/org.ganesha.nfsd.conf \
       /etc/dbus-1/system.d &&\
    rm -rf /usr/src/nfs-ganesha &&\
    adduser --disabled-password --gecos '' master &&\
    (echo pwd; echo pwd) | smbpasswd -a -s master &&\
    sed -i "/\[global\]/a\ \ \ include = registry" /etc/samba/smb.conf &&\
    apt-get clean &&\
    mkdir -p /etc/ganesha &&\
    mkdir -p /etc/service/rpcbind &&\
    mkdir -p /etc/service/ganesha &&\
    mkdir -p /etc/service/samba &&\
    mkdir -p /etc/service/dbus &&\
    apt-get purge -y \
      bison \
      build-essential \
      cmake \
      cmake-data \
      comerr-dev \
      cpp \
      cpp-4.8 \
      doxygen \
      dpkg-dev \
      flex \
      g++ \
      g++-4.8 \
      gcc \
      gcc-4.8 \
      git \
      git-core \
      git-man \
      libc6-dev \
      libcephfs-dev \
      libfl-dev \
      libgcc-4.8-dev \
      libkrb5-dev \
      libstdc++-4.8-dev \
      linux-libc-dev \
      make \
      manpages \
      manpages-dev \
      uuid-dev &&\
    apt-get autoremove -y

ADD dbus.sh /etc/service/dbus/run
ADD rpcbind.sh /etc/service/rpcbind/run
ADD ganesha.sh /etc/service/ganesha/run
ADD ganesha.conf /etc/ganesha/ganesha.conf
ADD samba.sh /etc/service/samba/run
