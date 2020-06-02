### Start by creating a "builder" ###  
# We'll compile all needed packages in the builder, and then  
# we'll just get only what we need for the actual APP  
# Use an official Python runtime as a parent image  
FROM python:3.5-slim as builder  
  
## install the gcc compiler  
# (needed to install some of the python packages):  
RUN apt-get update && apt-get upgrade -y && apt-get install -y \  
g++ \  
pkg-config \  
make \  
cmake \  
&& apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y  
  
## For now, install 'emacs', to be able to edit packages  
# in the builder:  
RUN apt-get update && apt-get upgrade -y && \  
apt-get install -y emacs && apt-get clean -y && \  
apt-get autoclean -y && apt-get autoremove -y  
  
# Install dckstack from github (using git):  
RUN apt-get update -qq && apt-get install -y git-core && \  
apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \  
cd /tmp && \  
git clone https://github.com/pvelasco/dcmstack.git && \  
cd dcmstack && \  
git checkout rf/py3 && \  
easy_install ./ && \  
cd / && rm -rf /tmp/dcmstack  
  
# Install dcm2niix from github:  
# Install also pigz-- it makes dcm2niix compress NIfTI files faster  
RUN apt-get update && apt-get upgrade -y && \  
apt-get install -y pigz && \  
apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \  
cd /tmp && \  
git clone https://github.com/rordenlab/dcm2niix.git && \  
cd dcm2niix && \  
git checkout tags/v1.0.20180328 && \  
mkdir build && cd build && cmake -DBATCH_VERSION=ON .. && \  
make && make install && \  
cd / && rm -rf /tmp/dcm2niix  
  
# Install heudiconv from github:  
RUN cd /tmp && \  
git clone https://github.com/cbinyu/heudiconv.git && \  
cd heudiconv && \  
git checkout master && \  
pip install . && \  
cd / && rm -rf /tmp/heudiconv  
  
# Get rid of some test folders in some of the Python packages:  
# (They are not needed for our APP):  
#RUN rm -fr /usr/local/lib/python3.5/site-packages/numpy  
RUN rm -fr /usr/local/lib/python3.5/site-packages/nibabel/nicom/tests && \  
rm -fr /usr/local/lib/python3.5/site-packages/nibabel/tests && \  
rm -fr /usr/local/lib/python3.5/site-packages/nibabel/gifti/tests  
#############  
### Now, get a new machine with only the essentials ###  
  
FROM python:3.5-slim as Application  
  
COPY --from=builder ./usr/local/lib/python3.5/ /usr/local/lib/python3.5/  
COPY --from=builder ./usr/local/bin/ /usr/local/bin/  
COPY --from=builder ./usr/bin/pigz /usr/bin/  
  
# Run app.py when the container launches:  
#ADD . /app  
ENTRYPOINT ["/usr/local/bin/heudiconv"]  

