FROM gendosu/alpine-ruby:2.2.3  
MAINTAINER jgilley@chegg.com  
  
RUN apk --update --no-cache add \  
bash \  
curl \  
ca-certificates \  
openssh \  
supervisor \  
qt-dev \  
nodejs \  
tzdata \  
libxml2-dev \  
libxslt-dev \  
qt5-qtwebkit && \  
rm -rf /var/cache/apk/* && \  
update-ca-certificates && \  
mkdir -p /app  
  
# Add the container config files  
COPY container_confs /  
  
# Set the working directory  
WORKDIR /app  
  
# set our environment  
ENV APP_ENV='DEVELOPMENT'  
ENV RUBY_ENV='DEVELOPMENT'  
ENV SERVICE_PORT 9292  
ENV SERVICE_IP 0.0.0.0  
# create the supervisor run dir  
# make sure that entrypoint and other scripts are executeable  
RUN mkdir -p /run/supervisord && \  
mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh && \  
chmod +x /entrypoint.sh /wait-for-it.sh /etc/profile /etc/profile.d/*.sh  
  
RUN apk add --no-cache curl && curl -o- -L https://yarnpkg.com/install.sh | sh  
ENV PATH /root/.yarn/bin:$PATH  
  
# the entry point definition  
ENTRYPOINT ["/entrypoint.sh"]  
  
# default command for entrypoint.sh  
CMD ["supervisor"]  

