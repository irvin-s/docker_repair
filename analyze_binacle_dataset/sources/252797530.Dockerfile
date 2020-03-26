FROM centos:latest  
MAINTAINER cmsj@tenshu.net  
RUN yum install -y golang-bin git && \  
go get github.com/mdlayher/unifi_exporter/cmd/unifi_exporter && \  
mv ~/go/bin/unifi_exporter /bin/ && \  
yum clean all && \  
rm -rf ~/go/  
EXPOSE 9130  
CMD ["/bin/unifi_exporter"]  

