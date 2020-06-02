##### docker file for PhenoX
  
FROM ubuntu:18.04

RUN buildDeps='build-essential g++ libgl1-mesa-glx wget git' \
                && apt update \
                && apt install -y $buildDeps

# Get PhenoX
WORKDIR /phenoX
RUN git clone https://github.com/NCBI-Hackathons/phenotypeXpression.git

WORKDIR /phenoX/phenotypeXpression/

# Modified to run miniconda3 to save some disk space headaches
RUN sed -i 's|archive/Anaconda3-4.3.1|miniconda/Miniconda3-4.5.12|' setup.sh
RUN sed -i 's/Anaconda3-4.3.1-/Miniconda3-4.5.12-/' setup.sh
RUN sed -i 's/anaconda3/miniconda3/' setup.sh

# Install conda and phenoX
RUN chmod +x setup.sh
RUN ./setup.sh

# Set up environment
RUN echo "source /root/miniconda3/bin/activate phenoX" > ~/.bashrc
ENV PATH /root/miniconda3/envs/phenoX/bin:$PATH

# to test run:
# docker run -it phenox 
# python run_phenox.py -e A.N.Other@example.com "Dermatitis"
