from tensorflow/tensorflow:0.12.1-gpu
RUN apt-get update && apt-get install -y libboost-all-dev libopencv-dev libgoogle-glog-dev git python-opencv
RUN pip install tqdm scikit_image==0.12.3 scikit-learn pydicom Pillow SimpleITK
RUN pip install xgboost
RUN rm -rf /usr/local/include/Eigen
ADD 3rd-party/dcm2niix /usr/local/bin/dcm2niix
ADD vcglib/vcg /usr/local/include/vcg
ADD vcglib/wrap /usr/local/include/wrap
ADD vcglib/eigenlib/Eigen /usr/local/include/Eigen
ADD vcglib/eigenlib /usr/local/include/eigenlib
ADD src-old /adsb3
RUN cd /adsb3 && python setup.py build && sudo python setup.py install

