FROM ubuntu:16.04  
ARG COMMIT  
ENV COMMIT ${COMMIT:-master}  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && apt-get install -y \  
curl libsnappy-dev autoconf automake libtool pkg-config \  
git  
  
WORKDIR /  
RUN git clone https://github.com/openvenues/libpostal  
WORKDIR /libpostal  
RUN git checkout $COMMIT  
COPY ./build_libpostal.sh .  
RUN ./build_libpostal.sh  
  
COPY ./build_libpostal_rest.sh .  
RUN ./build_libpostal_rest.sh  
  
EXPOSE 8080  
CMD /libpostal/workspace/bin/libpostal-rest  

