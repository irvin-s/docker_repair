FROM combro2k/alpine-base:latest  
  
ENV SUPW="admin"  
RUN apk --no-cache --quiet add murmur icu-libs && \  
apk del --quiet --no-cache --purge && \  
rm -rf /var/cache/apk/*  
  
COPY /resources/ /  
  
VOLUME /mumble  
  
EXPOSE 64738/udp 64738/tcp  

