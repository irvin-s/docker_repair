###############################################################################
# Dockerfile to build ${app_name} application container
# Based on ${base_image}
###############################################################################

# Use official python base image
FROM ${base_image}

# Install python dependencies
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt${github_installs_string}

# Create a default user. Available via runtime flag `--user ${username}`.
# Add user to "staff" group.
# Give user a home directory.
RUN (id -u ${username} >/dev/null 2>&1 || useradd ${username}) \
    && addgroup ${username} staff \
    && mkdir -p /home/${username} \
    && chown -R ${username}:staff /home/${username}

ENV HOME /home/${username}

# Copy the python script
COPY ${script_base_name} /home/${username}/

# Set working directory
WORKDIR /home/${username}

# Set entrypoint
ENTRYPOINT ["python", "/home/${username}/${script_base_name}"]
