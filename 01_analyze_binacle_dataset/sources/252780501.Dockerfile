FROM projectatomic/atomicapp:dev  
  
MAINTAINER Christoph Görn <goern@b4mad.net>  
  
LABEL io.projectatomic.nulecule.providers="openshift" \  
io.projectatomic.nulecule.specversion="0.0.2"  
  
ADD /Nulecule /Dockerfile README.md /application-entity/  
ADD /artifacts /application-entity/artifacts  

