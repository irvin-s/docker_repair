FROM ubuntu:16.04  
LABEL Description="Validate an ISA JSON file"  
MAINTAINER David Johnson, david.johnson@oerc.ox.ac.uk  
RUN apt-get -y update  
RUN apt-get -y install --no-install-recommends python3-pip  
RUN pip3 install --upgrade pip  
RUN pip3 install -U setuptools  
RUN pip3 install isatools==0.3.4  
  
ADD run_test.sh /usr/local/bin/run_test.sh  
RUN chmod +x /usr/local/bin/run_test.sh  
  
ADD run_validator.py /  
ENTRYPOINT ["python3", "run_validator.py"]  

