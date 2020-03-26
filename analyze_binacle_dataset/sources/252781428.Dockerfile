# Use an official Python runtime as a parent image  
FROM ubuntu:16.04  
# Install needed packages  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive \  
apt-get -y install build-essential checkinstall && \  
apt-get -y install gcc g++ && \  
apt-get -y install python2.7 python-pip && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
USER $USERNAME  
  
# Set the working directory  
WORKDIR /workd  
  
# Copy the current directory contents into the container at /prosynt  
ADD . /workd  
  
# Install any needed packages specified in requirements.txt  
RUN pip install --trusted-host pypi.python.org -r requirements.txt  
  
# Run app.py when the container launches  
CMD ["python", "test1.py"]  

