# Licensed under the Apache License, Version 2.0 (the "License"); you may  
# not use this file except in compliance with the License. You may obtain  
# a copy of the License at  
#  
# http://www.apache.org/licenses/LICENSE-2.0  
#  
# Unless required by applicable law or agreed to in writing, software  
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT  
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the  
# License for the specific language governing permissions and limitations  
# under the License.  
FROM fedora:28  
MAINTAINER Jiri Stransky <jistr@jistr.com>  
  
ADD rust-install/rebuild-counter /usr/local/share/rust-install/rebuild-counter  
  
RUN dnf -y update; dnf clean all  
  
# fundamental packages  
RUN dnf -y install file gcc make man sudo tar; dnf clean all  
  
ENV LD_LIBRARY_PATH /usr/local/lib  
ADD rust-install /usr/local/share/rust-install  
  
# pre-built:  
RUN /usr/local/share/rust-install/download-and-install.sh  
  
CMD ["/bin/bash"]  

