FROM python:alpine  
  
RUN pip install shadowsocks  
  
COPY shadowsocks.json /etc/shadowsocks.json  
  
EXPOSE 8388  
ENTRYPOINT ["ssserver"]  
  
CMD ["-c", "/etc/shadowsocks.json"]  

