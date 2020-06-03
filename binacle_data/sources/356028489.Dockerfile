FROM quay.io/coreos/flannelbox:1.0
MAINTAINER tangfeixiong <fxtang@qingyuanos.com>
#ADD ./flanneld /opt/bin/
#ADD ./mk-docker-opts.sh /opt/bin/
#CMD /opt/bin/flanneld
LABEL name="hterm2kube" version="0.1" description="kubectl, GitVersion: v1.4.0-alpha.1.209+03be7117a486c4"
ADD ./kubectl /bin/
#ADD ./.kube/config /root/.kube/config
ADD ./ssl/kubeconfig /root/.kube/config
ADD ./ssl/ca.pem ./ssl/admin.pem ./ssl/admin-key.pem /root/.kube
ADD ./.gotty /root/.gotty
ADD ./exec2hterm /exec2hterm
ADD ./dist /Users/emicklei/Projects/swagger-ui/dist
#ENV PATH $PATH:/root/bin
ENV PORT 18080
EXPOSE 18080
CMD ["exec2hterm"]
#ENTRYPOINT ["/exec2hterm"]