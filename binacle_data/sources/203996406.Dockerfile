FROM jacknlliu/ros:kinetic-gazebo9-nomoveit

LABEL maintainer="Jack Liu <jacknlliu@gmail.com>"
USER root

# copy scripts file
RUN mkdir -p /opt/scripts/container/ && chmod -R a+rx /opt/scripts/
COPY ./scripts/*.sh /opt/scripts/container/
RUN chmod a+rwx -R /opt/scripts/container && sync && cd /opt/scripts/container && ./install_gazebo_dart.sh


# install pydart2
RUN pip3 install numpy; pip3 install PyOpenGL PyOpenGL_accelerate; \
    aptitude install -q -y -R swig python3-pyqt5 python3-pyqt5.qtopengl && \
    pip3 install pydart2


# aptitude clean
RUN apt-get autoclean \
    && apt-get clean all \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*
