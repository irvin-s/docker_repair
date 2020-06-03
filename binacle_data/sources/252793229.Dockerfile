# Dockerfile to MAC Address Manufacturer Lookup container.  
# Official Dockerfile used: https://hub.docker.com/_/python  
FROM python:2.7  
MAINTAINER Roger CARHUATOCTO <chilcano at intix dot info>  
  
RUN pip install --upgrade pip  
RUN pip install unicodecsv  
RUN pip install Flask  
RUN pip install sqlalchemy  
RUN pip install pyOpenSSL  
RUN pip install -U flask-cors  
  
# Allocate the 5000/5443 to run a HTTP/HTTPS server  
EXPOSE 5000 5443  
COPY mac_manuf_wireshark_file.py /  
COPY mac_manuf_table_def.py /  
RUN python mac_manuf_wireshark_file.py  
COPY mac_manuf_api_rest.py /  
COPY mac_manuf_api_rest_https.py /  
COPY mac_manuf_run.sh /  
RUN ["chmod", "+x", "/mac_manuf_run.sh"]  
  
CMD ./mac_manuf_run.sh  

