###################################################################################
# Starting in Q1’2018, Beignet has been deprecated in favor of NEO OpenCL driver. #
# Beginet still remains the recommended driver for                                #
# - Sandybridge - 2nd Geneneration                                                #
# - Ivybridge - 3rd Geneneration                                                  #
# - Haswell - 4th Geneneration.                                                   #
###################################################################################
FROM boinc/client:baseimage-ubuntu

LABEL maintainer="BOINC" \
      description="Legacy Intel GPU-savvy BOINC client."

# Install
RUN apt-get update && apt-get install -y --no-install-recommends \
# Generic OpenCL ICD Loader
    ocl-icd-libopencl1 \
# OpenCL Driver for legacy HW platforms. 
    beignet-opencl-icd && \
# Cleaning up
    rm -rf /var/lib/apt/lists/*

