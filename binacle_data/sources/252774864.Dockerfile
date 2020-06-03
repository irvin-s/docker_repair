FROM python:3  
# TODO: Investigate why this and the following requirements are needed (copied  
# over from tailordev/pandas).  
ENV PYTHONUNBUFFERED 1  
# Install non-Pip requirements.  
RUN apt-get update -qq && \  
apt-get install -qqy --no-install-recommends libatlas-base-dev gfortran  
  
# Install Pandas and a bunch of PIP modules that are commonly used.  
RUN mkdir -p /opt/pandas/build/  
COPY requirements.txt /opt/pandas/build/requirements.txt  
RUN pip install -r /opt/pandas/build/requirements.txt  

