# A basic setup of powershell.
FROM centos:centos7

# Install library needed to allow Nutanix Powershell SDK to ignore SSL
# verification (used for testing purposes).
RUN yum -y install wget
RUN wget ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/Scott_Cantor/CentOS_7/x86_64/libcurl-openssl-7.43.0-1.1.x86_64.rpm
RUN rpm -i libcurl-openssl-7.43.0-1.1.x86_64.rpm

RUN yum -y install make
RUN yum -y install git

# Install dotnet SDK.
RUN rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
RUN yum update
RUN yum -y install dotnet-sdk-2.1

RUN git clone https://github.com/nutanix/Powershell

# Builds SDK
RUN cd Powershell && make

# Enables SDK to ignore SSL verification, which is useful for testing purposes.
RUN echo "export LD_LIBRARY_PATH=/opt/shibboleth/lib64/:$LD_LIBRARY_PATH" >> ~/.bashrc
