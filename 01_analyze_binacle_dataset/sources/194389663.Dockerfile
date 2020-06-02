FROM {{ base_image }}

# Copy all files to /tmp/grocker
COPY . /tmp/grocker

# Do provisioning
ARG SYSTEM_DEPENDENCIES
RUN /tmp/grocker/provision.sh

# Make the entry point run the compile script
USER grocker
WORKDIR /home/grocker
VOLUME /home/grocker/packages
ENTRYPOINT ["{{ runtime }}", "/home/grocker/compile.py"]
