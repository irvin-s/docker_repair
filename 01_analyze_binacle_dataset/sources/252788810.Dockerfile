FROM drigerg/python-base  
  
MAINTAINER Pradeep Kumar A.V. <pradeepkumar1025@gmail.com>  
  
# Basic dependencies  
RUN conda install -y bzip2 glib readline mkl openblas numpy scipy hdf5 \  
pillow matplotlib cython pandas gensim protobuf \  
lmdb leveldb boost glog gflags  
  
# Configure Matplotlib to use TkAgg by default  
RUN mkdir -p $HOME/.config/matplotlib && \  
echo "backend : TkAgg" > $HOME/.config/matplotlib/matplotlibrc  
  
# Scikit Image  
RUN pip install scikit-image  
  
# OpenCV  
RUN apt-get install -y libgtk2.0-dev > /dev/null  
RUN conda install -y -c menpo opencv3 && \  
python -c "import cv2;print(cv2.__version__)"  
RUN ldconfig  

