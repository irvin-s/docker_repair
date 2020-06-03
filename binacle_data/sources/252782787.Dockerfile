FROM python:3.4  
MAINTAINER Davy <me@davy.tw>  
  
# Clone the newest application  
RUN git clone https://github.com/rschiang/luffa.git  
  
# Make configuration split out,  
# you may use host file as data volume to replace this file  
RUN touch /config.json  
RUN ln -s /config.json /luffa/config.json  
  
# Get pip to download and install requirements  
RUN pip install -r /luffa/requirements.txt  
  
# Set the application path as working directory  
WORKDIR /luffa  
  
# Expose 80 port  
EXPOSE 80  
# Run the server on 80 port  
ENTRYPOINT /usr/local/bin/gunicorn luffa:application -b :80  
CMD ["-c"]  
  

