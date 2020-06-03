#https://hub.docker.com/r/bitxiong/tsn/
FROM bitxiong/tsn

RUN mkdir /app/lib/MPI

WORKDIR /app/lib/MPI

RUN apt-get update && \
    apt-get install -y openssh-client openssh-server && \
    pip install -i https://mirrors.ustc.edu.cn/pypi/web/simple opencv-python && \
    wget http://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz && \
    tar -zxvf mpich-3.2.1.tar.gz && \
	cd mpich-3.2.1 &&\
	./configure -prefix=/app/lib/MPI/mpich && \
    make && \
    make install  && \
    cd /app && \
	MPI_PREFIX=/app/lib/MPI/mpich/ bash build_all.sh MPI_ON

ENV PATH=/app/lib/MPI/mpich/bin:$PATH 

WORKDIR /app