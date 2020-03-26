FROM centos:6.9  
# Declare build-time environment  
# Miniconda  
ARG MC_VERSION=4.4.10  
ARG MC_PLATFORM=Linux  
ARG MC_ARCH=x86_64  
ARG MC_URL=https://repo.continuum.io/miniconda  
  
# Conda root  
ARG CONDA_VERSION=4.4.10  
ARG CONDA_BUILD_VERSION=3.5.0  
ARG CONDA_PACKAGES  
  
# Declare environment  
ENV OPT=/opt \  
HOME=/home/jenkins  
  
ENV PYTHONUNBUFFERED=1 \  
MC_VERSION=${MC_VERSION} \  
MC_PLATFORM=${MC_PLATFORM} \  
MC_ARCH=${MC_ARCH} \  
MC_URL=${MC_URL} \  
MC_INSTALLER=Miniconda3-${MC_VERSION}-${MC_PLATFORM}-${MC_ARCH}.sh \  
MC_PATH=${OPT}/conda \  
CONDA_VERSION=${CONDA_VERSION} \  
CONDA_BUILD_VERSION=${CONDA_BUILD_VERSION} \  
CONDA_PACKAGES=${CONDA_PACKAGES}  
  
# Toolchain  
RUN yum update -y && yum install -y \  
bzip2-devel \  
curl \  
gcc \  
gcc-c++ \  
gcc-gfortran \  
git \  
glibc-devel.i686 \  
glibc-devel \  
hg \  
java-1.8.0-openjdk-devel \  
kernel-devel \  
libX11-devel \  
mesa-libGL \  
mesa-libGLU \  
ncurses-devel \  
openssh-server \  
subversion \  
sudo \  
wget \  
zlib-devel \  
&& yum clean all  
  
# SSH Server configuration  
# Create 'jenkins' user  
# Configure sudoers  
RUN sed -i 's|#UseDNS.*|UseDNS no|' /etc/ssh/sshd_config \  
&& ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \  
&& ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa \  
&& groupadd jenkins \  
&& useradd -g jenkins -m -d $HOME -s /bin/bash jenkins \  
&& echo "jenkins:jenkins" | chpasswd \  
&& echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers  
  
# Install Miniconda  
# Reset permissions  
RUN curl -q -O ${MC_URL}/${MC_INSTALLER} \  
&& bash ${MC_INSTALLER} -b -p ${MC_PATH} \  
&& rm -rf ${MC_INSTALLER} \  
&& echo export PATH="${MC_PATH}/bin:\${PATH}" > /etc/profile.d/conda.sh \  
&& chown -R jenkins: ${OPT} ${HOME}  
  
# Configure Conda  
ENV PATH "${MC_PATH}/bin:${PATH}"  
USER jenkins  
RUN conda config --set auto_update_conda false \  
&& conda install --yes --quiet \  
conda=${CONDA_VERSION} \  
conda-build=${CONDA_BUILD_VERSION} \  
git \  
${CONDA_PACKAGES}  
  
# Inject custom handlers  
USER root  
ADD with_env /usr/local/bin  
  
WORKDIR ${HOME}  
  
EXPOSE 22  
CMD ["/bin/bash"]  

