FROM david6miji/gulp-tool:latest  
  
MAINTAINER David You <david6miji@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install c build tool  
RUN apt-get install -y build-essential  
  
# Install avr build tool  
RUN apt-get install -y gcc-avr  
RUN apt-get install -y avr-libc  
  
# Install elf tool  
RUN apt-get install -y libelf-dev  
  
# Install freeglut3-dev  
RUN apt-get install -y freeglut3-dev  
  
# Install gtkwave  
RUN apt-get install -y gtkwave  
  
# Install texinfo  
RUN apt-get install -y texinfo  
  
# Install ctags  
RUN apt-get install -y ctags  
  
# Install simavr  
WORKDIR /tmp/  
RUN git clone git://github.com/buserror-uk/simavr.git  
  
WORKDIR /tmp/simavr  
RUN make all  
RUN make install  
  
# Define working directory.  
WORKDIR /work  
  

