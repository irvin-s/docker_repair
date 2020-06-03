FROM sameersbn/ubuntu:14.04.20141026  
MAINTAINER sameer@damagehead.com  
  
  
  
ADD . /docker  
RUN chmod 755 /docker/travis.sh  
RUN export dir_root='/docker'  
#RUN test -v dir_root --> in which env do u think u r?!  
RUN echo "dir_root $dir_root"  
#RUN /docker/DKR/sudoers.sh --> first script to run before trying to use sudo  
RUN /docker/travis.sh  
  
#ADD assets/setup/ /app/setup/  
#RUN chmod 755 /app/setup/install  
#RUN /app/setup/install  
#ADD assets/init /app/init  
#RUN chmod 755 /app/init  
#VOLUME ["/home/gitlab_ci_runner/data"]  
#ENTRYPOINT ["/app/init"]  
#CMD ["app:start"]  
# Start MongoDB  
CMD mongod --fork -f /etc/mongodb.conf \  
&& redis-server /etc/redis/redis.conf \  
&& bash  

