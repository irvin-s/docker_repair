USER root

# Add dependency
RUN apt-get update

RUN apt-get install -y libhdf5-dev libnetcdf-dev
RUN apt-get install -y python-matplotlib
RUN apt-get install -y libgeos-3.4.2
RUN apt-get install -y libgeos-dev

RUN pip install git+https://github.com/earthserver-eu/OWSLib@olcl-wcs-200


USER main

# Install requirements for Python 2
ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt
