FROM conda/miniconda3

LABEL maintainer="PyMC Devs https://github.com/pymc-devs/pymc4"

ARG SRC_DIR
ARG PYTHON_VERSION

ENV PYTHON_VERSION=${PYTHON_VERSION}


# Change behavior of create_test.sh script
ENV DOCKER_BUILD=true

# For Sphinx documentation builds
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Update container
RUN apt-get update && apt-get install -y git build-essential pandoc vim \
    && rm -rf /var/lib/apt/lists/*


# Copy requirements and environment installation scripts
COPY $SRC_DIR/requirements.txt  opt/pymc4/
COPY $SRC_DIR/requirements-dev.txt  opt/pymc4/
COPY $SRC_DIR/scripts/ opt/pymc4/scripts
WORKDIR /opt/pymc4


# Create conda environment. Defaults to Python 3.6
RUN ./scripts/create_testenv.sh


# Set automatic conda activation in non interactive and shells
ENV BASH_ENV="/root/activate_conda.sh"
RUN echo ". /root/activate_conda.sh" > /root/.bashrc


# Remove conda cache
RUN conda clean --all

COPY $SRC_DIR /opt/pymc4

# Clear any cached files from copied from host filesystem
RUN find -type d -name __pycache__ -exec rm -rf {} +

