FROM bigm/base-deb

# install nfs
RUN /xt/tools/_apt_install nfs-kernel-server netbase

ENV NFS_EXPORT_FOLDER /exports
RUN mkdir -p $NFS_EXPORT_FOLDER

# final
ADD supervisor/* /etc/supervisord.d/
ADD startup/* /prj/startup/
EXPOSE 111/udp 2049/tcp

ADD nfs-run.sh /usr/local/bin/nfs-run
#CMD ["/usr/local/bin/nfs-run"]


# https://www.howtoforge.com/nfs_ssh_tunneling
RUN sed -i 's/^RPCMOUNTDOPTS=.*/RPCMOUNTDOPTS="--manage-gids --port 2233"/' /etc/default/nfs-kernel-server
