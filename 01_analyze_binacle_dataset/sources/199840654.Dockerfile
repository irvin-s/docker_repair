# Purpose:
#   Create a Docker image that contains a DataPower Gateway. The resulting
#   image will have the WebGUI enabled so the license can be accepted.
#
# Usage:
# 1) Place the DataPower debian packages in the docker build directory
# 2) Rename the packages ibm-datapower-common.deb and ibm-datapower-image.deb
#    respectively.
# 3) Issue the command "docker build ."
#
# Notes:
# After building the DataPower image, run it mapping port 8080. Browse to
# the mapped port and accept the license.
#
# To access the cli, issue the following command:
# docker run -it <datapower-container> telnet localhost 2200

FROM ubuntu:trusty

# Place *only* the one common deb and one image deb in the local directory
# before running docker build
COPY ibm-datapower-common.deb ibm-datapower-image.deb /tmp/

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies, enable web-mgmt, prepare for first run.
# Don't carry the deb packages forward in the image
RUN echo "Installing dependencies" \
    && apt-get update \
    && apt-get -y install \
          kpartx \
          schroot \
          telnet \
    && echo "Installing DataPower Packages" \
    && dpkg -i /tmp/ibm-datapower-common.deb /tmp/ibm-datapower-image.deb \
    && echo "Enabling WebGUI" \
    && sed -i \
          -e '/^web-mgmt/,/^exit/s/admin-state.*/admin-state "enabled"/g' \
          /opt/ibm/datapower/datapower-external.cfg \
    && echo "Removing intermediate package files" \
    && rm /tmp/ibm-datapower-common.deb /tmp/ibm-datapower-image.deb \
    && echo "Preparing to run" \
    && /opt/ibm/datapower/datapower-docker-build.sh \
    && mkdir -p /datapower/config /datapower/local \
    && echo "DataPowerConfigDir=/datapower/config" >> /opt/ibm/datapower/datapower.conf \
    && echo "DataPowerLocalDir=/datapower/local" >> /opt/ibm/datapower/datapower.conf \
    && echo "DataPowerCpuCount=4" >> /opt/ibm/datapower/datapower.conf


# EXPOSE the port for the WebGUI.
EXPOSE 9090

CMD ["/opt/ibm/datapower/datapower-launch"]
