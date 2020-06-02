FROM ubuntu:16.04  
# Install packages.  
RUN apt-get update  
RUN apt-get install -y python python-dev python-pip  
RUN apt-get install -y libjpeg-dev libopencv-dev python-opencv  
RUN apt-get install -y python-qt4  
RUN apt-get install -y cython  
RUN apt-get install -y pyfai  
RUN apt-get install -y gfortran  
RUN pip install --upgrade musclex  
  
#RUN pip install --upgrade pip  
#RUN pip install --upgrade scikit-image  
#RUN pip install --upgrade tifffile  
#RUN pip install --upgrade numpy  
#RUN pip install --upgrade pandas  
#RUN pip install --upgrade scikit-learn  
#RUN pip install --upgrade lmfit  
#RUN pip install --upgrade ConfigParser  
#RUN pip install --upgrade pillow  
#RUN pip install --upgrade fabio  
#RUN pip install --upgrade cython  
#RUN pip install --upgrade peakutils  
#RUN pip install --upgrade h5py  
#RUN pip install --upgrade scipy  
#RUN pip install --upgrade matplotlib  
#RUN pip install --upgrade musclexflibs  
#RUN pip install --upgrade PyMca5  
#ADD musclex /musclex/musclex  
#  
#ADD LICENSE.txt /musclex/LICENSE.txt  
#ADD MANIFEST /musclex/MANIFEST  
#ADD README.md /musclex/README.md  
#ADD setup.cfg /musclex/setup.cfg  
#ADD setup.py /musclex/setup.py  
#ENV TMP_PATH $PYTHONPATH  
#ENV PYTHONPATH /musclex/:$TMP_PATH  
#WORKDIR /musclex/  
#RUN python /musclex/setup.py install  
#  
#ENV PYTHONPATH $TMP_PATH  
ADD tests /musclex_test/tests  
RUN python -m unittest discover -s /musclex_test/tests -p '*_test.py'  

