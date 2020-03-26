# A basic setup of powershell.
FROM centos:centos7

RUN yum -y install wget
RUN wget ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/Scott_Cantor/CentOS_7/x86_64/libcurl-openssl-7.43.0-1.1.x86_64.rpm
RUN rpm -i libcurl-openssl-7.43.0-1.1.x86_64.rpm

RUN yum -y install make
RUN yum -y install git

RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/microsoft.repo
RUN rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
RUN curl https://download.mono-project.com/repo/centos7-stable.repo | tee /etc/yum.repos.d/mono-centos7-stable.repo
RUN yum -y install yum-utils
RUN yum -y install powershell
RUN yum -y install dotnet-sdk-2.1.0
RUN git clone https://github.com/nutanix/Powershell
RUN cd Powershell && make
RUN echo "export LD_LIBRARY_PATH=/opt/shibboleth/lib64/:$LD_LIBRARY_PATH" >> ~/.bashrc
