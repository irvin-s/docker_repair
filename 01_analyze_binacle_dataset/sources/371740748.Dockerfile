FROM gettyimages/spark

# Install dependencies
RUN apt-get update \
	&& apt-get install -y gcc g++ cmake python python-dev python-pip \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./scripts/install-opencv-linux.sh ./install-opencv-linux.sh

# Install opencv
RUN ./install-opencv-linux.sh