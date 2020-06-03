FROM weaveworks/weaveexec:1.4.5

WORKDIR /opt/localkube

COPY start.sh ./start.sh
ADD localkube-linux ./localkube

ENV PATH /opt/localkube:$PATH

ENTRYPOINT ["start.sh"]
