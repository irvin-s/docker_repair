FROM centos:centos6
MAINTAINER Jim White <mailto:jimwhite@uw.edu>

# Here I only install tools which we must have:
RUN yum -y update && \
	yum -y install wget which git rpm-build tar time \
		gcc gcc-c++ make flex libtool aclocal autoheader automake autoconf \
		boost-devel && \
	yum clean all

# An alternative would be to install the dev group and then the few extras we need:
# 	yum groupinstall -y "Development Tools" && \
# 	yum install -y wget which git rpm-build boost-devel && \

# Need libLBFGS
# It is available in Fedora 21 and Rawhide but we're doing Centos 6 here (because of HTCondor).
WORKDIR /tmp
RUN	wget https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/source/SRPMS/l/liblbfgs-1.10-4.fc22.src.rpm && \
	rpmbuild --rebuild --clean liblbfgs-1.10-4.fc22.src.rpm && \
	rpm -i `find ~/rpmbuild/RPMS -name "liblbfgs*rpm"`

# Get and build the BLLIP parser (but not training programs - leave that to next image).
WORKDIR /home
RUN git clone https://github.com/BLLIP/bllip-parser.git && \
	cd bllip-parser && \
	make 

CMD [ "/bin/bash" ]
