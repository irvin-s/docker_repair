FROM centos:7
ADD . /bin
ENTRYPOINT [ "/bin/oauth-proxy" ]
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
