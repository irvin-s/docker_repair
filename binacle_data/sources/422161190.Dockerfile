FROM centos:7

RUN set -xe \
    && yum -y install gcc glibc-devel make ncurses-devel openssl-devel autoconf \
                      curl git cmake check check-devel automake systemd-devel \
                      patch gcc-c++ redhat-lsb-core nmap-ncat rpm-build lzo-devel \
                      sysstat wget sudo nc

RUN set -xe \
    && curl -O https://raw.githubusercontent.com/kerl/kerl/master/kerl \
    && chmod a+x kerl \
    && mkdir -p ~/bin \
    && mv kerl ~/bin \
    && echo "export PATH=$PATH:~/bin" >> ~/.bashrc \
    && echo 'KERL_CONFIGURE_OPTIONS="--disable-hipe --enable-smp-support --enable-threads --enable-kernel-poll --enable-systemd" ' > ~/.kerlrc \
    && ~/bin/kerl build 19.3 19.3_systemd \
    && mkdir -p ~/erlang/19.3_systemd \
    && ~/bin/kerl install 19.3_systemd ~/erlang/19.3_systemd/ \
    && echo "source ~/erlang/19.3_systemd/activate" >> ~/.bashrc \
    && git clone https://github.com/leo-project/leofs_package.git \
    && mkdir -p ~/rpm/{BUILD,RPMS,SOURCES,SPECS,SRPMS} \
    && cp leofs_package/rpm/make_rpm.sh ~/rpm/SPECS \
    && cp leofs_package/rpm/leofs.spec ~/rpm/SPECS \
    && cp leofs_package/common/check_version.sh ~/rpm/SPECS

RUN set -xe \
    && yum -y install which \
    && wget https://github.com/github/hub/releases/download/v2.5.0/hub-linux-amd64-2.5.0.tgz \
    && tar xzf hub-linux-amd64-2.5.0.tgz \
    && ./hub-linux-amd64-2.5.0/install

ADD run_packaging.sh /root/rpm/SPECS

WORKDIR /root/rpm/SPECS

CMD bash
