FROM alpine:3.1  
ENV NGINX_VERSION="1.9.12"  
ENV NGINX_SHA="5945a0701f0ee0755fd20643f755507996a3f7f3"  
RUN apk --update add \  
git \  
openssl-dev \  
pcre-dev \  
zlib-dev \  
wget \  
perl \  
perl-dev \  
imagemagick \  
imagemagick-dev \  
build-base  
  
ADD build.sh /tmp/build.sh  
RUN sh /tmp/build.sh \  
rm /tmp/build.sh  
  
RUN mkdir -p /var/nginx/cache  
ADD files/nginx.conf /etc/nginx/nginx.conf  
WORKDIR /etc/nginx  
  
EXPOSE 80 443  
ENV OMP_NUM_THREADS=1  
CMD ["nginx", "-g", "daemon off;"]  

