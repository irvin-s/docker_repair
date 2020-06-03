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

WORKDIR /usr/bin

ARG SCORING_SCRIPT

ENV MODEL_XML_PATH none
ENV DEVICE none
ENV INPUT none
ENV CONNECTIONSTRING none
ENV OUTPUT_DIR  none

ENV LD_LIBRARY_PATH=/usr/lib:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

RUN apt update && \
    apt -y install python3.5 python3-pip zip x11-apps lsb-core

#### Install Intel OpenVINO pre-requisites
RUN apt install -y libpng12-dev libcairo2-dev libpango1.0-dev libglib2.0-dev libgtk2.0-dev libswscale-dev libavcodec-dev libavformat-dev libgstreamer1.0-0 gstreamer1.0-plugins-base build-essential cmake libusb-1.0-0-dev
RUN pip3 install numpy

# Application specific steps
RUN pip3 install azure-iothub-device-client
RUN apt -y install libboost-python-dev

# Install OpenCL driver and runtime
RUN apt -y install libnuma1 ocl-icd-libopencl1 wget
RUN wget https://github.com/intel/compute-runtime/releases/download/18.28.11080/intel-opencl_18.28.11080_amd64.deb
RUN dpkg -i intel-opencl_18.28.11080_amd64.deb
RUN rm intel-opencl_18.28.11080_amd64.deb

#### Set env paths according to $INTEL_CVSDK_DIR/bin/setupvars.sh
ENV INSTALLDIR=/opt/intel/computer_vision_sdk
ENV INTEL_CVSDK_DIR=${INSTALLDIR}
ENV LD_LIBRARY_PATH=${INSTALLDIR}/deployment_tools/model_optimizer/model_optimizer_caffe/bin:${LD_LIBRARY_PATH}
ENV ModelOptimizer_ROOT_DIR=${INSTALLDIR}/deployment_tools/model_optimizer/model_optimizer_caffe
ENV InferenceEngine_DIR=${INTEL_CVSDK_DIR}/deployment_tools/inference_engine/share
ENV IE_PLUGINS_PATH=${INTEL_CVSDK_DIR}/deployment_tools/inference_engine/lib/ubuntu_16.04/intel64
ENV LD_LIBRARY_PATH=/opt/intel/opencl:${INSTALLDIR}/deployment_tools/inference_engine/external/cldnn/lib:${INSTALLDIR}/inference_engine/external/gna/lib:${INSTALLDIR}/deployment_tools/inference_engine/external/mkltiny_lnx/lib:${IE_PLUGINS_PATH}:${LD_LIBRARY_PATH}
ENV OpenCV_DIR=${INSTALLDIR}/opencv/share/OpenCV
ENV LD_LIBRARY_PATH=${INSTALLDIR}/opencv/lib:${INSTALLDIR}/opencv/share/OpenCV/3rdparty/lib:${LD_LIBRARY_PATH}
ENV PATH=${INTEL_CVSDK_DIR}/deployment_tools/model_optimizer:$PATH
ENV PYTHONPATH=${INTEL_CVSDK_DIR}/deployment_tools/model_optimizer:$PYTHONPATH
ENV PYTHONPATH=$INTEL_CVSDK_DIR/python/python3.5:${INTEL_CVSDK_DIR}/python/python3.5/ubuntu16:${PYTHONPATH}

COPY ${SCORING_SCRIPT} .
# Convert ARG to ENV variable
ENV SCORING_SCRIPT=${SCORING_SCRIPT}

CMD python3.5 ${SCORING_SCRIPT} -l ${IE_PLUGINS_PATH}/libcpu_extension_avx2.so -i ${INPUT} -m ${MODEL_XML_PATH} -d ${DEVICE} -o ${CONNECTIONSTRING}
