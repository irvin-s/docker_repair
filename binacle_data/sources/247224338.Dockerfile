# Based on instructions for hardware acceleration from http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration 
FROM osrf/ros:indigo-desktop-full

RUN apt-get update && apt-get install -y \
        ros-indigo-velodyne 
	# don't flush the apt cache for now since we probably need to install more stuff.

# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

RUN mkdir -p /src

WORKDIR /src
