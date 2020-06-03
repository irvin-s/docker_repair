FROM centos:latest  
RUN yum -y install git qemu-img which sudo && yum clean all  
RUN git clone https://git.openstack.org/openstack/diskimage-builder && \  
git clone https://git.openstack.org/openstack/dib-utils  
ENV PATH /diskimage-builder/bin:/dib-utils/bin:$PATH  

