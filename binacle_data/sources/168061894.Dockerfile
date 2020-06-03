FROM sequenceiq/spark:1.1.0
MAINTAINER smungee

#RUN yum -y install numpy scipy python-matplotlib gcc gcc-c++

# Following needed to build numpy, scikit-learn
RUN yum -y install gcc gcc-c++ lapack lapack-devel blas blas-devel python-devel
RUN yum clean all

RUN curl https://bootstrap.pypa.io/get-pip.py > get-pip.py
RUN python get-pip.py 
RUN pip install -U numpy scipy scikit-learn
#RUN easy_install -U cython scikit-image

# Reduce number of warning messages
ADD log4j.properties /usr/local/spark/conf/log4j.properties

# Needed for Spark to run in Yarn mode
ENV MASTER yarn
CMD ["/etc/bootstrap.sh", "-d"]
