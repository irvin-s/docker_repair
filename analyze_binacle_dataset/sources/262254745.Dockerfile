FROM alpine

RUN \
  apk update && \
  apk add curl bash bash-completion jq util-linux

ADD diagnostic-curl-mesos diagnostic-curl-marathon md mesos-cli marathon-cli /usr/local/bin/
ADD marathon-cli-completion md-completion mesos-cli-completion /usr/local/share/bash-completion/
ADD dcos-support /usr/local/share/
ADD docker-assets/bashrc /root/.bashrc

CMD ["/bin/bash"]

