FROM djpetti/docker-keras
MAINTAINER Daniel Petti

# Install dependencies.
RUN apt-get update
RUN apt-get install -y python-liblinear python-tk
RUN pip install opencv-contrib-python==3.4.2.17

# Install Rhodopsin
RUN git clone https://github.com/djpetti/rhodopsin.git
RUN cd rhodopsin && python setup.py install
