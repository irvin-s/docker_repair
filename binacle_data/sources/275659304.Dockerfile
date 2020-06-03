FROM rootproject/root-ubuntu16

# Run the following commands as super user (root):
USER root

# Create a user that does not have root privileges 
ARG username=physicist
RUN userdel builder && useradd --create-home --home-dir /home/${username} ${username}
ENV HOME /home/${username}

# Switch to our newly created user
USER ${username}

# Our working directory will be in a mounted directory named data
WORKDIR /data

# When starting the container and no command is started, run macro in ROOT and quit.
CMD ["root.exe", "-q", "/usr/local/share/doc/root/tutorials/dataframe/tdf002_dataModel.C"]
