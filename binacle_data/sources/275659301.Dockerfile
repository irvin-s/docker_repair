FROM rootproject/root-ubuntu16

# Run the following commands as super user (root):
USER root

# Install required packages for notebooks
RUN apt-get update && apt-get install -y python-pip && pip install --upgrade pip && pip install \
       jupyter \
       metakernel \
       zmq \
     && rm -rf /var/lib/apt/lists/*

# Create a user that does not have root privileges 
ARG username=physicist
RUN userdel builder && useradd --create-home --home-dir /home/${username} ${username}
ENV HOME /home/${username}

WORKDIR /home/${username}

# Add some example notebooks
ADD http://root.cern.ch/doc/master/notebooks/mp201_parallelHistoFill.C.nbconvert.ipynb mp201_parallelHistoFill.C.nbconvert.ipynb
ADD http://root.cern.ch/doc/master/notebooks/tdf007_snapshot.py.nbconvert.ipynb tdf007_snapshot.py.nbconvert.ipynb

# Create the configuration file for jupyter and set owner
RUN echo "c.NotebookApp.ip = '*'" > jupyter_notebook_config.py && chown ${username} *

# Switch to our newly created user
USER ${username}

# Allow incoming connections on port 8888
EXPOSE 8888

# Start ROOT with the --notebook flag to fire up the container
CMD ["root", "--notebook"]
