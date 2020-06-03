FROM centos
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install nodejs npm
EXPOSE 8080
ENV PORT 8080 
ENV CLUSTER api.demo.apcera.net
ENV username "admin"
ENV password "admin"
ADD * /
CMD cd /;npm install;node main.js
