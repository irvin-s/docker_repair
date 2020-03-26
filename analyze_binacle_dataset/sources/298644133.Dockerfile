# Base image from Python ${pythonVersion} (slim)
FROM python:${pythonVersion}-slim

VOLUME ["/opt/${name}-config"]

# Copy application files
COPY . /tmp/build
WORKDIR /tmp/build

# Clean application
RUN python ./clean.py

# Install application package and its dependencies
RUN pip install .

# Cleanup build
RUN rm -rf /tmp/build

################### INSTALLATION END #######################
#
# Run the application.
#
# NOTE: The configuration files for the application must be
#       mapped to the path: /opt/${name}-config
#
# For example, specify a "-v" argument to the run command
# to mount a directory on the host as a data volume:
#
#   -v /host/dir/to/config:/opt/${name}-config
#
CMD ["python", "-m", "${name}", "/opt/${name}-config"]
