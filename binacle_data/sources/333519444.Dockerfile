FROM hirs/hirs-ci:centos7

# Install packages for installing HIRS TPM2 Provisioner
RUN yum -y update && yum clean all
RUN yum install -y tpm2-tools libcurl procps-ng wget dbus python-requests && yum clean all

# Install PACCOR for Device Info Gathering
RUN mkdir paccor && pushd paccor && wget https://github.com/nsacyber/paccor/releases/download/v1.1.2r1/paccor-1.1.2-1.noarch.rpm && yum -y install paccor-*.rpm && popd

# Install Software TPM for Provisioning
RUN mkdir ibmtpm && pushd ibmtpm && wget https://downloads.sourceforge.net/project/ibmswtpm2/ibmtpm1119.tar.gz && tar -zxvf ibmtpm1119.tar.gz && cd src && make -j5 && popd
