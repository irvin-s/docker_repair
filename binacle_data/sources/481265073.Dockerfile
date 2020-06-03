# Pull base image
FROM centos:7

RUN yum install -y java-1.8.0-openjdk

# deploy user dubbo service
RUN mkdir iPaaS-Service-Dubbo && cd /iPaaS-Service-Dubbo && mkdir 3rd-libs lib config
COPY ./build/3rd-libs/*.jar /iPaaS-Service-Dubbo/3rd-libs/
COPY ./build/libs/*.jar /iPaaS-Service-Dubbo/lib/
COPY ./build/all-config /iPaaS-Service-Dubbo/config/

# remove some libs
RUN rm -rf /iPaaS-Service-Dubbo/3rd-libs/httpcore-4.2.5.jar /iPaaS-Service-Dubbo/3rd-libs/httpclient-4.2.6.jar

## copy config files
#RUN cd /iPaaS-Service-Dubbo/config && mkdir context 
#COPY ./context/* /iPaaS-Service-Dubbo/config/context/

## copy start script
COPY ./ipaas_service_dubbo.sh /ipaas_service_dubbo.sh
RUN chmod 755 /ipaas_service_dubbo.sh

#设置时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone

# set start parameter for dubbo service
ENV COMMON_LIB_HOME /iPaaS-Service-Dubbo
ENV PATH $CATALINA_HOME/bin:$PATH

# Expose ports.
EXPOSE 29181

# Define default command.
CMD ["/ipaas_service_dubbo.sh"]
