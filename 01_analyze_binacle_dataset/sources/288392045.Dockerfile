FROM centos:centos7
ARG POD_USER

RUN yum install -y curl which bind-utils docker kubernetes-client golang git sudo
RUN yum install -y centos-release-openstack-ocata
RUN yum install -y mariadb-server-galera rsync resource-agents

RUN rm -f /etc/my.cnf.d/auth_gssapi.cnf
RUN mkdir /var/run/mysql && chown mysql:mysql /var/run/mysql

COPY *.sh database.sql peer-finder.go /

# Necessary if runing with OpenShift's nonroot or anyuid SCC is not possible
# https://blog.openshift.com/jupyter-on-openshift-part-6-running-as-an-assigned-user-id/
# 
RUN chmod g+w /etc/passwd

ENV GOPATH=/go POD_USER=${POD_USER:-mysql}
RUN go get k8s.io/apimachinery/pkg/util/sets/

ENTRYPOINT /fixuser_and_run.sh
CMD ["/bin/go", "run", "/peer-finder.go", "-on-change", "/on-change.sh"]

USER $POD_USER
