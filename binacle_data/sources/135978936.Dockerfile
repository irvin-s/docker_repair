# CI docker CPU env
# Adapted from github.com/dmlc/tvm/docker/Dockerfile.ci_cpu
FROM ubuntu:16.04

RUN apt-get update --fix-missing

COPY install/ubuntu_install_core.sh /install/ubuntu_install_core.sh
RUN bash /install/ubuntu_install_core.sh

COPY install/ubuntu_install_build.sh /install/ubuntu_install_build.sh
RUN bash /install/ubuntu_install_build.sh

# ANTLR deps
COPY install/ubuntu_install_java.sh /install/ubuntu_install_java.sh
RUN bash /install/ubuntu_install_java.sh

COPY install/ubuntu_install_antlr.sh /install/ubuntu_install_antlr.sh
RUN bash /install/ubuntu_install_antlr.sh

# python
COPY install/ubuntu_install_python.sh /install/ubuntu_install_python.sh
RUN bash /install/ubuntu_install_python.sh

COPY install/ubuntu_install_python_package.sh /install/ubuntu_install_python_package.sh
RUN bash /install/ubuntu_install_python_package.sh

COPY install/ubuntu_install_torch.sh /install/ubuntu_install_torch.sh
RUN bash /install/ubuntu_install_torch.sh

COPY install/ubuntu_install_mxnet_cpu.sh /install/ubuntu_install_mxnet_cpu.sh
RUN bash /install/ubuntu_install_mxnet_cpu.sh
