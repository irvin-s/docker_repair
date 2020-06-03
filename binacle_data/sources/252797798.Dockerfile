FROM cocoon/python  
MAINTAINER cocoon  
  
  
RUN apt-get update && apt-get clean  
  
# install vim  
RUN apt-get install -yq vim  
ADD files/vimrc /.vimrc  
  
# install git  
RUN apt-get install -yq git-core  
  
RUN pip install fig  
RUN pip install docker-py  
RUN pip install ansible  
RUN pip install Ipython  
  
# install docker tools  
ADD files/opt/dockertools /opt/dockertools  
  
# share the docker bin with the host  
#ENV DOCKER_BIN=$(which docker)  
#ADD $(which docker) /opt/dockertools/bin/  
ENV PATH /opt/dockertools/bin:$PATH  
  
RUN mkdir /projects  
WORKDIR /projects  
  
CMD /bin/bash  
  

