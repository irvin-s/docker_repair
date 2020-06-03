FROM nitnelave/caffe
MAINTAINER Valentin Tolmer "valentin.tolmer@gmail.com"

RUN cd /caffe && \
    git remote add yosinski https://github.com/yosinski/caffe.git && \
    git fetch --all && \
    git checkout --track -b deconv-deep-vis-toolbox yosinski/deconv-deep-vis-toolbox && \
    make clean && \
    make -j$(nproc) && \
    make -j$(nproc) pycaffe

RUN git clone https://github.com/yosinski/deep-visualization-toolbox && \
    cd deep-visualization-toolbox && \
    cp models/caffenet-yos/settings_local.template-caffenet-yos.py settings_local.py
