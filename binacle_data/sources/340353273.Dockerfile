# This is an auto generated Dockerfile for ros:desktop
# generated from docker_images_ros2/create_ros_image.Dockerfile.em
FROM ros:bouncy-ros-base-bionic
# install ros2 packages
RUN apt-get update && apt-get install -y \
    ros-bouncy-desktop=0.5.1-0* \
    && rm -rf /var/lib/apt/lists/*

