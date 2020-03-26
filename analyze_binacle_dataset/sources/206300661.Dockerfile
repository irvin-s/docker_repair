FROM mesos-update
MAINTAINER Kevin Klues <klueska@mesosphere.com>

# Calling 'nvidia-docker run' will perform something
# equivalent to the following when it sees this label
# in the image:
# --privileged \
# -v nvidia_driver_<driver_version>:/usr/local/nvidia:ro \
# -v /dev/nvidiactl:/dev/nvidiactl \
# -v /dev/nvidia-uvm:/dev/nvidia-uvm \
# -v /dev/nvidia*:/dev/nvidia*
LABEL com.nvidia.volumes.needed=nvidia_driver

# Set up some paths so we can find the nvidia driver binaries.
ENV PATH=/usr/local/nvidia/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Uninstall the NVML stub library in favor of the real one we mount in.
RUN rm -rf /opt/nvidia-gdk && \
    rm -rf /etc/ld.so.conf.d/nvidia-lib64.conf && \
    ldconfig

# Create a wrapper script to add the dynamically mounted nvidia libraries to
# ldconfig before running the mesos agent.
RUN echo " \
    ldconfig /usr/local/nvidia/lib; \
    ldconfig /usr/local/nvidia/lib64; \
    mesos-agent \
        --master=zk://localhost:2181/mesos \
        --launcher=linux \
        --image_providers=docker \
        --containerizers=mesos \
        --isolation=docker/runtime,filesystem/linux,cgroups/devices,gpu/nvidia \
        --work_dir=/var/lib/mesos \
        --log_dir=/var/log/mesos \
        --no-systemd_enable_support" \
    > mesos-agent-wrapper

RUN chmod a+x mesos-agent-wrapper

# Run the agent.
ENTRYPOINT ./mesos-agent-wrapper
