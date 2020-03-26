FROM pathtrk/docker-cmake-opencv-boost

COPY . /code
WORKDIR /code
RUN cmake .
