# BSD 3-clause "New" or "Revised" license
#
# Copyright (C) 2018 Intel Coporation.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

FROM ubuntu:16.04 



ENV LD_LIBRARY_PATH=/usr/lib:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

RUN apt update && \
    apt -y install python3.5 python3-pip zip x11-apps lsb-core wget cpio sudo libboost-python-dev libpng-dev zlib1g-dev git libnuma1 ocl-icd-libopencl1 clinfo libboost-filesystem1.58.0 libboost-thread1.58.0 protobuf-compiler libprotoc-dev

RUN pip3 install numpy networkx opencv-python

COPY l_openvino_*.tgz .
RUN tar -xzf l_openvino_toolkit*.tgz && \
    rm -rf l_openvino_toolkit*.tgz && \
    cd l_openvino_toolkit* && \
    sed -i 's/decline/accept/g' silent.cfg && \
    ./install.sh -s silent.cfg && \
    ./install_cv_sdk_dependencies.sh && \
    cd - && \
    rm -rf l_openvino_toolkit*


RUN wget https://github.com/intel/compute-runtime/releases/download/19.15.12831/intel-gmmlib_19.1.1_amd64.deb
RUN wget https://github.com/intel/compute-runtime/releases/download/19.15.12831/intel-igc-core_1.0.2-1787_amd64.deb
RUN wget https://github.com/intel/compute-runtime/releases/download/19.15.12831/intel-igc-opencl_1.0.2-1787_amd64.deb
RUN wget https://github.com/intel/compute-runtime/releases/download/19.15.12831/intel-opencl_19.15.12831_amd64.deb
RUN wget https://github.com/intel/compute-runtime/releases/download/19.15.12831/intel-ocloc_19.15.12831_amd64.deb

RUN sudo dpkg -i *.deb

#### Set env paths according to $INTEL_CVSDK_DIR/bin/setupvars.sh
ENV INSTALLDIR=/opt/intel/computer_vision_sdk
ENV INTEL_CVSDK_DIR=${INSTALLDIR}
ENV LD_LIBRARY_PATH=${INSTALLDIR}/deployment_tools/model_optimizer/model_optimizer_caffe/bin:${LD_LIBRARY_PATH}
ENV ModelOptimizer_ROOT_DIR=${INSTALLDIR}/deployment_tools/model_optimizer/model_optimizer_caffe
ENV InferenceEngine_DIR=${INTEL_CVSDK_DIR}/deployment_tools/inference_engine/share
ENV IE_PLUGINS_PATH=${INTEL_CVSDK_DIR}/deployment_tools/inference_engine/lib/ubuntu_16.04/intel64
ENV LD_LIBRARY_PATH=/opt/intel/opencl:${INSTALLDIR}/deployment_tools/inference_engine/external/cldnn/lib:${INSTALLDIR}/inference_engine/external/gna/lib:${INSTALLDIR}/deployment_tools/inference_engine/external/mkltiny_lnx/lib:${INSTALLDIR}/deployment_tools/inference_engine/external/omp/lib:${IE_PLUGINS_PATH}:${LD_LIBRARY_PATH}
ENV OpenCV_DIR=${INSTALLDIR}/opencv/share/OpenCV
ENV LD_LIBRARY_PATH=${INSTALLDIR}/opencv/lib:${INSTALLDIR}/opencv/share/OpenCV/3rdparty/lib:${LD_LIBRARY_PATH}
ENV PATH=${INTEL_CVSDK_DIR}/deployment_tools/model_optimizer:$PATH
ENV PYTHONPATH=${INTEL_CVSDK_DIR}/deployment_tools/model_optimizer:$PYTHONPATH
ENV PYTHONPATH=$INTEL_CVSDK_DIR/python/python3.5:${INTEL_CVSDK_DIR}/python/python3.5/ubuntu16:${PYTHONPATH}
ENV HDDL_INSTALL_DIR=${INSTALLDIR}/deployment_tools/inference_engine/external/hddl
ENV LD_LIBRARY_PATH=${INSTALLDIR}/deployment_tools/inference_engine/external/hddl/lib:$LD_LIBRARY_PATH

RUN rm -rf *.deb

ARG DEVICE

RUN wget "https://cmake.org/files/v3.13/cmake-3.13.3.tar.gz" && tar -xzvf cmake-3.13.3.tar.gz && cd cmake-3.13.3/ && ./bootstrap && make -j4 && make install && rm -rf /cmake-3.13.3.tar.gz && rm -rf /cmake-3.13.3

RUN git clone --recursive https://github.com/intel/onnxruntime /onnxruntime && \
    cd /onnxruntime/cmake/external/onnx && python3 setup.py install && \
    cd /onnxruntime && ./build.sh --config RelWithDebInfo --update --build --parallel --use_openvino $DEVICE --build_wheel && \
    pip3 install /onnxruntime/build/Linux/RelWithDebInfo/dist/*-linux_x86_64.whl && rm -rf /onnxruntime

