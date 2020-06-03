FROM ubuntu:16.04
RUN apt-get update && apt-get install -y libblas3 libc6 liblapack3 gcc gfortran python3-dev\
    libgcc1 libgfortran3 libstdc++6 g++ graphviz build-essential\
    python3-tk tk-dev libpng12-dev curl python3-pip git && apt-get autoclean
COPY requirements.txt .
RUN python3 -m pip install -r requirements.txt
