FROM centos:centos7

MAINTAINER Lars Solberg <lars.solberg@gmail.com>

RUN yum install -y tar net-tools

RUN mkdir /lynis && cd /lynis && \
    curl http://cisofy.com/files/lynis-1.5.7.tar.gz > lynis.tgz && \
    tar -zxvf lynis.tgz --strip-component=1

WORKDIR /lynis

# This is far from perfect, but lets do our best so Lynis is able to get to our "real" files..
# TODO: Merge to 1 find
RUN find . -type f | xargs -I{} sed 's@/etc/@/host_root/etc/@g' -i {} && \
    find . -type f | xargs -I{} sed 's@/tmp/@/host_root/tmp/@g' -i {} && \
    find . -type f | xargs -I{} sed 's@/home/@/host_root/home/@g' -i {} && \
    find . -type f | xargs -I{} sed 's@/var/@/host_root/var/@g' -i {} && \
    find . -type f | xargs -I{} sed 's@/root/@/host_root/root/@g' -i {}

ENTRYPOINT ["sh", "lynis"]
CMD ["--checkall", "--quick"]
