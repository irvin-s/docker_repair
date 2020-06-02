# LICENSE CDDL 1.0 + GPL 2.0
#
# Example httpd 2.4 with WebLogic module
# --------------------------------------
# This Dockerfile will build an httpd image for OpenShift that proxies to
# the rhel7-weblogic-sampleapp
#
# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# fmw_12.2.1.1.0_wlsplugins_Disk1_1of1.zip
#
# Download from:
# http://www.oracle.com/technetwork/middleware/webtier/downloads/index-jsp-156711.html 
#
# The zip archive must be made available for download at a URL specified in
# FMW_BASEURL.
#
# BUILD ENVIRONMENT VARIABLES
# -----------------------
# The following environment variables are required:
#
# FMW_BASEURL - Base http or https bath from which to download the weblogic
#               zip archive.
#
# FMW_VERSION - Set to the desired version as matching zip archive
#               (ex: 12.2.1.1.0)
# 
FROM registry.access.redhat.com/rhscl/httpd-24-rhel7
MAINTAINER Johnathan Kupferer <jkupfere@redhat.com>

ENV FMW_VERSION=${FMW_VERSION:-12.2.1.1.0} \
    LD_LIBRARY_PATH=/opt/app-root/mod_wl/
ENV FMW_BASEURL=${FMW_BASEURL:-http://fileserv.libvirt:8008/}
ENV FMW_PKG=fmw_${FMW_VERSION}_wlsplugins_Disk1_1of1.zip

# Download zip file to /opt/app-root/src
ADD ${FMW_BASEURL}${FMW_PKG} /opt/app-root/src

# Copy over customized httpd config.
COPY httpd.conf /opt/rh/httpd24/root/etc/httpd/conf/httpd.conf

# Yes, Oracle really distributes this as a zip in a zip in another zip!
# Unpack this mess to get the required files then clean up.
RUN mkdir /opt/app-root/src/extract && \
    cd /opt/app-root/src/extract && \
    unzip /opt/app-root/src/${FMW_PKG} && \
    unzip WLSPlugins12c-${FMW_VERSION}.zip && \
    unzip WLSPlugin${FMW_VERSION}-Apache2.2-Apache2.4-Linux_x86_64-12.2.1.1.0.zip && \
    mkdir -p /opt/app-root/mod_wl && \
    cp lib/lib* /opt/app-root/mod_wl/ && \
    cp lib/mod_wl_24.so /opt/app-root/mod_wl/mod_wl_24.so && \
    chmod a+rX -R /opt/app-root/mod_wl/ && \
    cd /opt/app-root/src && \
    rm -rf extract ${FMW_PKG} 

CMD [ "httpd", "-D" , "FOREGROUND" ]
