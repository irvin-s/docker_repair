FROM centos:latest
# ENV GIT_CURL_VERBOSE 1

ADD AMON_RPM_FILE var/agent.rpm

RUN yum -t -y install /var/agent.rpm

RUN /etc/init.d/amon-agent status

RUN /etc/init.d/amon-agent test
RUN ls -lh /etc/amonagent/plugins

RUN amonpm install boo
RUN amonpm update


CMD ["/bin/bash"]