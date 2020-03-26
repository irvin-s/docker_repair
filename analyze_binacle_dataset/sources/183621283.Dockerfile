FROM scratch
ADD mesos-dns_rootfs.tar.gz /
EXPOSE 53
CMD ["/usr/bin/mesos-dns"]
