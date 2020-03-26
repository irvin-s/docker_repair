FROM centos:7

VOLUME /data

RUN ["yum", "install", "-y", "epel-release"]
RUN ["yum", "install", "-y", "rsync", "bridge-utils", "qemu-kvm", "qemu-system-x86", "parted", "sudo", "openssh-clients", "nmap-ncat"]

RUN groupadd -r axsh && useradd -d /home/axsh -g axsh axsh && mkdir -p /home/axsh/.openvdc
WORKDIR /home/axsh

COPY ["multibox", "/multibox"]
COPY ["run_tests.sh", "run_tests.sh"]
COPY ["dot_openvdc-config.toml", "/home/axsh/.openvdc/config.toml"]
RUN chown -R axsh /home/axsh/.openvdc

ARG BRANCH
ARG RELEASE_SUFFIX
ARG REBUILD

# Set the ARGs to ENV because otherwise they're not visible to the run_tests.sh script
ENV BRANCH=${BRANCH:-master} RELEASE_SUFFIX=${RELEASE_SUFFIX:-current} REBUILD=${REBUILD:-false}

LABEL "jp.axsh.vendor"="Axsh Co. LTD"  \
      "jp.axsh.project"="OpenVDC" \
      "jp.axsh.task"="acceptance test" \
      "jp.axsh.branch"="$BRANCH" \
      "jp.axsh.release_suffix"="$RELEASE_SUFFIX"

ENTRYPOINT ["./run_tests.sh", "RUN"]
