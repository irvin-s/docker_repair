FROM python:3.6-stretch  
  
RUN apt-get update && apt-get install -y \  
gcc \  
gfortran \  
g++ \  
build-essential \  
libgrib-api-dev  
  
RUN pip install numpy pyproj  
  
RUN git clone https://github.com/jswhit/pygrib.git pygrib && \  
cd pygrib && git checkout tags/v2.0.2rel  
  
COPY setup.cfg ./pygrib/setup.cfg  
  
RUN cd pygrib && python setup.py build && python setup.py install  
  
CMD ["python"]  

