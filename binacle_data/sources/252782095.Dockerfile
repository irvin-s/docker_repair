FROM sonarqube:6.1  
  
# define Docker image label information  
LABEL com.ciandt.vendor="CI&T Software SA" \  
com.ciandt.maintainers.1="Ivan Pinatti - @ivan_pinatti" \  
com.ciandt.maintainers.2="Thomas Bryan - @thobryan"  
# copy Sonar plugins  
COPY plugins /opt/sonarqube/extensions/plugins  
  
# defines root user, to perform privileged operations  
USER root  
  
# upgrade packages, install security updates and required packages  
RUN readonly PACKAGES=" \  
make \  
" \  
&& apt-get update \  
&& apt-get upgrade \--assume-yes \  
&& apt-get install --no-install-recommends \  
\--assume-yes \  
${PACKAGES} \  
# remove apt cache in order to improve Docker image size  
&& apt-get clean  
  
# environment variables  
ENV SONAR_PROPERTIES_FILE=${SONARQUBE_HOME}/conf/sonar.properties  
  
# copy scripts  
RUN mkdir --parents /root/ciandt  
COPY ciandt /root/ciandt  

