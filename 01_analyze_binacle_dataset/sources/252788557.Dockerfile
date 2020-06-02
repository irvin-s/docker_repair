# Pull base image.  
FROM ubuntu:latest  
  
# Install Base  
RUN apt-get update  
RUN apt-get -y upgrade  
RUN apt-get install -y build-essential  
RUN apt-get install -y ca-certificates  
RUN apt-get install -y curl git htop man unzip vim wget  
  
# Install Python 3.6  
RUN apt-get install -y software-properties-common  
RUN add-apt-repository -y ppa:jonathonf/python-3.6  
RUN apt-get update  
RUN apt-get install -y python3.6 python3.6-dev  
  
# Make Python 3.6 aliases (see: https://stackoverflow.com/q/36388465)  
RUN rm -rf /usr/bin/python3  
RUN ln -s $(which python3.6) /usr/bin/python3  
RUN ln -s $(which python3.6) /usr/bin/python  
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.6  
  
# Install Packages  
RUN apt-get install -y sqlite3 libsqlite3-dev  
RUN apt-get install -y python3-scipy  
RUN apt-get install -y freetype* pkg-config  
RUN pip install \  
requests six pytz arrow pdf virtualenv \  
networkx html5lib decorator \  
jupyter pandas numpy matplotlib scipy \  
scikit-learn seaborn scikit-image \  
fpdf datascience ipywidgets  
RUN pip install okpy  
RUN pip install --upgrade okpy  
  
# Cleanup  
RUN apt-get autoremove -y  
RUN rm -rf /var/lib/apt/lists/*  
  
# Set environment variables.  
ENV HOME /root  
  
# TODO: Run as non root user  
# Define working directory.  
WORKDIR /root  
  
# Define default command.  
CMD ["bash"]  

