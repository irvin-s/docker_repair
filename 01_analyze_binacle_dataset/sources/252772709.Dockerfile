FROM debian:buster  
LABEL maintainer="Benny Li <dev@benny-li.de>"  
##### Add a non-root app user #####  
ARG APP_USER="userless"  
ARG APP_USER_GROUP="groupless"  
ENV APP_USER="$APP_USER"  
ENV APP_USER_GROUP="$APP_USER_GROUP"  
RUN groupadd $APP_USER_GROUP  
RUN echo "CREATE_MAIL_SPOOL no" >> /etc/default/useradd && \  
useradd \  
\--create-home \  
-g $APP_USER_GROUP \  
$APP_USER  
# In sub-Dockerfiles you can install stuff by doing  
# USER root  
# RUN apk add ...  
# USER $APP_USER  
USER $APP_USER  
  
WORKDIR /home/$APP_USER  

