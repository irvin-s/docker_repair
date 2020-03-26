FROM bbinet/hooked  
  
MAINTAINER Bruno Binet <bruno.binet@helioslite.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && \  
apt-get install -yq --no-install-recommends openssh-client git ca-certificates  
  
ADD hooked.cfg /etc/hooked.cfg  
ADD run.sh /run.sh  
RUN chmod a+x /run.sh  
ADD git-workdir.sh /git-workdir.sh  
RUN chmod a+x /git-workdir.sh  
  
ENV GIT_REPO_PATH /repositories  
ENV GIT_WORKDIR_PATH /workdir  
ENV GIT_SSH /usr/bin/ssh  
ENV HOOKED_CONFIG /etc/hooked  
ENV BEFORE_EXEC_SCRIPT ${HOOKED_CONFIG}/before-exec.sh  
  
EXPOSE 80  
ENV EXEC_CMD hooked ${HOOKED_CONFIG}/hooked.cfg  
  
CMD ["/run.sh"]  

