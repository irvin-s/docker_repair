#   Copyright 2019 1QBit
#   
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

FROM fedora:28

RUN dnf -y update
RUN dnf -y install wget libgomp openblas-devel pandoc
RUN dnf clean all


# Openfermion and ProjectQ installation dependencies
RUN dnf -y install gcc redhat-rpm-config gcc-c++ python3-devel

# We do this because pyscf refuses to link to the system OpenBLAS in the pip
# install so we force load that version ahead of the one that it ships with.
ENV LD_PRELOAD=/usr/lib64/libopenblas.so

# Python modules for documentation, Jupyter notebook support, visualization
# and some computational packages
RUN pip3 install 'ipython==7.4.0' jupyter 'pyscf==1.6' twine \
    numpy 'scipy==1.2' matplotlib setuptools wheel sphinx py3Dmol \
    sphinx_rtd_theme nbsphinx


################### Microsoft QDK environment ###################

# Install QDK
WORKDIR /tmp/
RUN dnf clean all
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc
RUN wget -q https://packages.microsoft.com/config/fedora/27/prod.repo
RUN mv prod.repo /etc/yum.repos.d/microsoft-prod.repo
RUN chown root:root /etc/yum.repos.d/microsoft-prod.repo
RUN dnf install -y dotnet-sdk-2.2

# Install the IQSharp backend
RUN dotnet tool install -g Microsoft.Quantum.IQSharp --version 0.7.1905.3109
RUN /root/.dotnet/tools/dotnet-iqsharp install --user

# Install python package
RUN pip3 install qsharp==0.7.1905.3109

########################### Finalize #############################

# Set the python path to find openqemist
ENV PYTHONPATH=$PYTHONPATH:/root/openqemist

WORKDIR /root/
