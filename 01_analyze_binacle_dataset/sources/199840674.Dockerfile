# Purpose:   
#   Create a Docker image that contains a DataPower Gateway. The resulting   
#   image will have the WebGUI enabled so the license can be accepted.   
#   
# Usage:   
# 1) Place the DataPower rpm packages in the docker build directory   
# 2) Rename the packages ibm-datapower-common.rpm and ibm-datapower-image.rpm   
#    respectively.   
# 3) Issue the command " docker build "     
#   
# Notes:   
# After building the DataPower image, run it mapping port 9090. Browse to   
# the mapped port and accept the license.   
#   
# To access the cli, issue the following command:   
# docker run -it <datapower-container> telnet localhost 2200   
   
FROM rhel7.2
   
# Place *only* the one common rpm and one image rpm in the local directory   
# before running docker build   
COPY ibm-datapower-common.rpm ibm-datapower-image.rpm /tmp/   
   
# Install dependencies, enable web-mgmt, prepare for first run.   
# Do not carry the rpm packages forward in the image   
RUN echo "Installing dependencies" \
    && set -x \
    && yum -y update \
    && rpm -Uvh 'http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm' \ 
    && yum -y install \
          telnet \
          net-tools \
          e2fsprogs \
    && echo "Installing DataPower Packages" \
    && yum -y install /tmp/ibm-datapower-image.rpm \
    && yum -y install /tmp/ibm-datapower-common.rpm \
    && echo "Enabling WebGUI" \
    && sed -i \
          -e '/^web-mgmt/,/^exit/s/admin-state.*/admin-state "enabled"/g'  \
          /opt/ibm/datapower/datapower-external.cfg \
    && echo "Removing intermediate package files" \
    && rm /tmp/ibm-datapower-common.rpm  tmp/ibm-datapower-image.rpm \
    && echo "Preparing to run" \
    && /opt/ibm/datapower/datapower-docker-build.sh \
    && mkdir -p /datapower/config /datapower/local \
    && echo "DataPowerConfigDir=/datapower/config" >> /opt/ibm/datapower/datapower.conf \
    && echo "DataPowerLocalDir=/datapower/local" >> /opt/ibm/datapower/datapower.conf \
    && echo "DataPowerCpuCount=4" >> /opt/ibm/datapower/datapower.conf
   
# EXPOSE the port for the WebGUI.   
EXPOSE 9090   
   
CMD ["/opt/ibm/datapower/datapower-launch"]   
