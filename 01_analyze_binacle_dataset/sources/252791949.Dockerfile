FROM billryan/gitbook:base  
MAINTAINER Rhett <yuanbin2014@gmail.com>  
  
# add non-root user(workaround for docker)  
# replace gid and uid with your currently $GID and $UID  
#RUN useradd -m -g 100 -u 1000 gitbook  
#USER gitbook  
# install gitbook versions  
RUN gitbook fetch latest  
  
RUN apt-get update; DEBIAN_FRONTEND=noninteractive apt-get install -y awscli  
  
ENV BOOKDIR /gitbook  
  
VOLUME $BOOKDIR  
  
EXPOSE 4000  
WORKDIR $BOOKDIR  
  
CMD ["gitbook", "--help"]  
  

