FROM centos:7.2.1511

MAINTAINER Eric Robertson <rwgdrummer@gmail.com>:

ENV BLENDER_MAJOR 2.76
ENV BLENDER_VERSION 2.76b
ENV BLENDER_BZ2_URL http://download.blender.org/source/blender-2.77.tar.gz

RUN groupadd blender
RUN useradd -m -g blender -d /home/blender -p blender123 blender
RUN yum install -y sudo
RUN yum -y install wget
RUN yum -y install openssl openssl-devel
RUN yum -y install bzip2-devel openssl-devel ncurses-devel
RUN yum groupinstall "Development tools" -y

# Edit sudoers file # To avoid error: sudo: sorry, you must have a tty to run sudo
RUN sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers
RUN echo "blender ALL=(ALL)       ALL" >> /etc/sudoers

RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm
RUN rpm -Uvh http://download1.rpmfusion.org/free/el/updates/6/i386/rpmfusion-free-release-6-1.noarch.rpm
RUN rpm -Uvf http://dl.fedoraproject.org/pub/epel/7/x86_64/g/geos-3.4.2-2.el7.x86_64.rpm
RUN rpm -Uvf http://dl.fedoraproject.org/pub/epel/7/x86_64/g/geos-devel-3.4.2-2.el7.x86_64.rpm
RUN rpm -Uvf http://dl.fedoraproject.org/pub/epel/7/x86_64/g/geos-python-3.4.2-2.el7.x86_64.rpm

WORKDIR /root
RUN wget --no-check-certificate https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tgz
RUN tar -zxvf Python-3.5.1.tgz 
RUN rm Python-3.5.1.tgz
WORKDIR /root/Python-3.5.1
RUN ./configure --prefix=/usr/local LDFLAGS="-Wl,-rpath /usr/local/lib" --with-ensurepip=install
RUN make && make altinstall
WORKDIR /root
RUN rm -rf /root/Python-3.5.1

RUN mkdir -p /home/blender/src/blender-deps
WORKDIR /home/blender/src/blender-deps/
RUN wget http://ffmpeg.org/releases/ffmpeg-2.8.4.tar.gz
RUN tar xvf ffmpeg-2.8.4.tar.gz

WORKDIR /home/blender
RUN wget $BLENDER_BZ2_URL
RUN tar xf blender-2.77.tar.gz
WORKDIR /home/blender/blender-2.77/build_files/build_environment

RUN mkdir -p /root/src
RUN ln -s /home/blender/src/blender-deps /root/src/blender-deps
#wget http://llvm.org/releases/3.6.2/clang+llvm-3.6.2-x86_64-fedora21.tar.xz
RUN printf 'y\n' | ./install_deps.sh --with-all --force-llvm --build-oiio --build-llvm --skip-osl --build-foo --build-ffmpeg

WORKDIR /home/blender/blender-2.77
RUN make
WORKDIR /home/blender
RUN rm blender-2.77.tar.gz && mkdir tmp && chown -R blender:blender * 

#ENV PYTHONHOME /usr/local/lib/python3.5
#ENV PYTHONPATH /usr/local/lib/python3.5:/usr/local/bin
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/blender/build_linux/bin
RUN /usr/local/bin/pip3.5 install --upgrade pip
RUN /usr/local/bin/pip3.5 install shapely
#RUN /usr/local/bin/pip install shapely
WORKDIR /home/blender/build_linux/bin/2.77/python/lib/python3.5
RUN ln -s  /usr/local/lib/python3.5/site-packages/shapely shapely
WORKDIR /home/blender
RUN yum -y install emacs
#RUN chown -R *
RUN chown -R blender:blender /home/blender

USER blender
ENV PYTHONHOME /usr/local/lib/python3.5/
ENV PYTHONPATH /home/blender:/home/blender/build_linux/bin/2.77/python/lib:/usr/local/lib/python3.5
ENV TMP /home/blender/tmp
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/blender/build_linux/bin
COPY SceneControl.py img_meta.py cust_render.py  \
     img_desc.csv truck_with_constraints_cycles.blend config.properties /home/blender/
COPY img1.png img2.png img3.png  /home/blender/

VOLUME /home/blender
#ENTRYPOINT ["/usr/local/blender/blender", "-b"]
CMD ["/bin/bash"]
