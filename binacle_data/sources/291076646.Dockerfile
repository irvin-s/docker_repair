# pull latest stable slim image of debian
FROM debian:stretch-slim

# update package list and install requirements for miniconda
RUN apt-get update -y
RUN apt-get install bzip2 -y
RUN apt-get install wget -y

# install anaconda and set up PATH variable
RUN wget https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh
RUN bash Anaconda3-5.3.1-Linux-x86_64.sh -p /conda -b
RUN rm Anaconda3-5.3.1-Linux-x86_64.sh
ENV PATH=/conda/bin:${PATH}

# install pystan
RUN conda install pystan -y

# expose port for jupyter
EXPOSE 8888

# set entrypoint for terminal
ENTRYPOINT ["/bin/bash"]