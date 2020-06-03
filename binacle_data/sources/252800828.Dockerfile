FROM centos:7  
MAINTAINER Ariel Alonso <xsaint32@gmail.com>  
  
ENV PLAYBOOK "site.yml"  
ENV EXTRA_VARS ""  
ENV VERBOSITY ""  
# Configure dependencies  
RUN yum install -y epel-release  
RUN yum install -y sudo tar ansible wget which bzip2 libselinux-python  
  
COPY ./docker-entrypoint.sh /  
COPY ./run-playbook.sh /  
  
RUN chmod a+x /docker-entrypoint.sh && \  
chmod a+x /run-playbook.sh  
  
# Run container  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["run"]  

