FROM ubuntu:14.04

MAINTAINER Dhaval Thakkar <dhaval.thakkar@somaiya.edu>

ARG PIP=/root/anaconda3/bin/pip

# Install some dependencies
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24
RUN sudo su -c "echo 'deb http://ppa.launchpad.net/git-core/ppa/ubuntu trusty main' > /etc/apt/sources.list.d/git.list"
RUN apt-get update && apt-get install -y \
		git -y \
		qt5-default -y \
                build-essential \
                cmake \
                curl \
                g++ \
                nano \
                pkg-config \
                software-properties-common \
                unzip \
                vim \
		gcc \
		graphviz \
                wget \
                doxygen \
                && \
        apt-get clean && \
        apt-get autoremove && \
        rm -rf /var/lib/apt/lists/* 


#Anaconda
RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh && \
    bash Anaconda3-4.4.0-Linux-x86_64.sh -b

#Setup .bashrc
RUN rm -r /root/.bashrc
COPY bashrc.txt /root/.bashrc
RUN alias brc='source ~/.bashrc'

# Installing TensorFlow
RUN ${PIP} --no-cache-dir install \	
	https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.3.0-cp36-cp36m-linux_x86_64.whl

# Installing PyTorch
RUN ${PIP} --no-cache-dir install \
	http://download.pytorch.org/whl/cu75/torch-0.2.0.post3-cp36-cp36m-manylinux1_x86_64.whl && \
	${PIP} --no-cache-dir install \
	torchvision

# Installing Numpy for the current user (BUGFIX)
RUN ${PIP} --no-cache-dir install -U numpy

# Installing MXNet
RUN ${PIP} --no-cache-dir install \
	mxnet==0.11.0

#Installing Keras
RUN ${PIP} --no-cache-dir install keras

# Install OpenCV
RUN git clone --depth 1 https://github.com/opencv/opencv.git /root/opencv && \
	cd /root/opencv && \
	mkdir build && \
	cd build && \
	cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON .. && \
	make -j"$(nproc)"  && \
	make install && \
	ldconfig && \
	echo 'ln /dev/null /dev/raw1394' >> ~/.bashrc

#Setup notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006 8888

WORKDIR "/root"
CMD ["/bin/bash"]

