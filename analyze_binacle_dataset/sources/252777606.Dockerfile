FROM python:3.6  
MAINTAINER Anthony K GROSS<anthony.k.gross@gmail.com>  
  
WORKDIR /src  
  
ENV COLOR "#FF0000"  
ENV SIZE "32"  
COPY entrypoint.sh /entrypoint.sh  
  
RUN apt-get update -y && \  
apt-get upgrade -y && \  
apt-get install -y python-pip && \  
pip install icon_font_to_png && \  
rm -rf /var/lib/apt/lists/* && \  
apt-get autoremove -y --purge && \  
mkdir /logs -p && \  
chmod 777 /logs -Rf && \  
chmod 777 /src -Rf && \  
chmod +x /entrypoint.sh  
  
RUN sh /entrypoint.sh install  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["run"]

