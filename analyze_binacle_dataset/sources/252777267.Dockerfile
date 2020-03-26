###  
# Build:  
# docker build -t wisdom/wisdom-framework .  
#  
# Run:  
# docker run -d -p 9000:9000 wisdom/wisdom-framework  
#  
# Optional volumes:  
# \- Logs: /wisdom/logs  
# \- Applications (where app bundles live): /wisdom/application  
# \- Conf (where configuration lives) : /wisdom/conf  
#  
# bash:  
# docker run -d \  
# -p 9000:9000 \  
# -v `pwd`/target/wisdom/logs:/wisdom/logs \  
# -v `pwd`/target/wisdom/application:/wisdom/application \  
# wisdom/wisdom-framework  
#  
# fish:  
# docker run -d \  
# -p 9000:9000 \  
# -v (pwd)/target/wisdom/logs:/wisdom/logs \  
# -v (pwd)/target/wisdom/application:/wisdom/application \  
# -v (pwd)/target/wisdom/conf:/wisdom/conf \  
# wisdom/wisdom-framework  
#  
#  
###  
FROM java:8  
  
RUN mkdir -p /wisdom  
ADD target/wisdom /wisdom  
  
# Expose the port 9000 (http), https is disabled by default  
EXPOSE 9000  
  
# Remove conf and application on build  
ONBUILD RUN rm -Rf /wisdom/application/*  
ONBUILD RUN rm -Rf /wisdom/conf/*  
  
# Change workdir.  
WORKDIR /wisdom  
  
RUN mkdir /wisdom/logs; touch /wisdom/logs/wisdom.log  
  
# For easier handling, we dump the log, so `docker logs containerId` displays  
# the log.  
CMD ./chameleon.sh; tail -F logs/wisdom.log  

