# Start with cutorch + opencv + dlib image
FROM nightseas/torch-opencv-dlib:cv2.4.13-dlib19.0-cuda8.0-ubuntu16.04

MAINTAINER Xiaohai Li <haixiaolee@gmail.com>

# Install python deps
RUN pip install numpy scipy pandas scikit-learn scikit-image

# Install torch deps
RUN luarocks install dpnn && \
  luarocks install image && \
  luarocks install optim  && \
  luarocks install csvigo && \
  luarocks install torchx && \
  luarocks install optnet && \
  luarocks install graphicsmagick && \
  luarocks install tds

# Fetch & install openface
RUN git clone https://github.com/cmusatyalab/openface.git /root/openface && \
  cd /root/openface && git submodule init && git submodule update

RUN cd /root/openface && \
    ./models/get-models.sh && \
    pip install -r requirements.txt && \
    python setup.py install && \
    pip install -r demos/web/requirements.txt && \
    pip install -r training/requirements.txt

RUN cd /root/openface && \
  ./data/download-lfw-subset.sh

# Expose the ports that are used by web demo
EXPOSE 8000 9000

CMD /bin/bash -l -c '/root/openface/demos/web/start-servers.sh'
