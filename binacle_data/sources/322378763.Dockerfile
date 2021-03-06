FROM registry.redhat.io/rhel7:latest
WORKDIR /root/containerbuild

# Only need a few of our scripts for the first few steps
COPY ./src/cmdlib.sh ./build.sh ./deps*.txt ./vmdeps.txt ./build-deps.txt /root/containerbuild/
COPY ./maipo/maipo.repo /etc/yum.repos.d/
RUN ./build.sh configure_yum_repos
# ostree-packages are on another line because all repos get configured to exclude
# ostree/rpm-ostree in the configure step above
COPY ./maipo/ostree-packages.repo /etc/yum.repos.d/
RUN ./build.sh install_rpms

# Ok copy in the rest of them for the next few steps
COPY ./ /root/containerbuild/
RUN ./build.sh write_archive_info
RUN ./build.sh make_and_makeinstall
RUN ./build.sh configure_user

RUN make clean

# clean up scripts (it will get cached in layers, but oh well)
WORKDIR /srv/
RUN rm -rf /root/containerbuild

# allow writing to /etc/passwd from arbitrary UID
# https://docs.openshift.com/container-platform/3.10/creating_images/guidelines.html
RUN chmod g=u /etc/passwd

# run as `builder` user
USER builder
ENTRYPOINT ["/usr/bin/dumb-init", "scl", "enable", "rh-python36", "--", "/usr/bin/coreos-assembler"]
