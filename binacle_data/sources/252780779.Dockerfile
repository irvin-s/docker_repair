FROM debian:jessie  
  
ENV DEBIAN_FRONTEND="noninteractive"  
RUN apt-get update -qq && \  
apt-get install -y curl locales openssl git netcat mc && \  
echo "ru_UA.UTF-8 UTF-8" >> /etc/locale.gen && \  
locale-gen && \  
dpkg-reconfigure --frontend noninteractive locales && \  
update-locale LANG=ru_UA.UTF-8 && \  
echo Europe/Kiev > /etc/timezone && \  
dpkg-reconfigure --frontend noninteractive tzdata && \  
apt-get -qq clean  
  
ENV LANG ru_UA.UTF-8  
ENV LANGUAGE ru_UA.UTF-8  
ENV LC_ALL ru_UA.UTF-8  
EXPOSE 8000  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod a+x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["bash"]  

