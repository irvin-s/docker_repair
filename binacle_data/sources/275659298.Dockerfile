FROM rootproject/root-ubuntu16

# Run the following commands as super user (root):
USER root

# Create a user that does not have root privileges 
ARG username=physicist
RUN userdel builder && useradd --create-home --home-dir /home/${username} ${username}
ENV HOME /home/${username}

# Switch to our newly created user
USER ${username}

# Our working directory will be in our home directory where we have permissions
WORKDIR /home/${username}

# Copy the hello.c file to our current working directory
COPY hello.C .

# When starting the container and no command is started, run hello.c in ROOT and quit.
CMD ["root.exe", "-q", "hello.C"]
