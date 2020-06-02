FROM ubuntu:16.04
  
# Install Python Setuptools
RUN apt-get install -y python-setuptools
  
# Install pip
RUN easy_install pip
  
# Add and install Python modules
ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN cd /lib;make

# Bundle app source
ADD . 
  
# Expose
EXPOSE 9004
  
# Run
CMD ["python", "service.py"]
