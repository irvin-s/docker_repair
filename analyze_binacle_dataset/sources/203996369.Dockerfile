FROM jacknlliu/ros:kinetic-core

LABEL maintainer="Jack Liu <jacknlliu@gmail.com>"

RUN apt-get update -y && apt-get install -y --no-install-recommends curl bzip2 libfreetype6 \
		libgl1-mesa-dev libglu1-mesa libxi6 libxrender1 module-init-tools

# thanks to [ikester/blender-docker](https://github.com/ikester/blender-docker/tree/2.78c)
ENV BLENDER_MAJOR 2.79
ENV BLENDER_VERSION 2.79
ENV BLENDER_BZ2_URL http://mirror.cs.umn.edu/blender.org/release/Blender$BLENDER_MAJOR/blender-$BLENDER_VERSION-linux-glibc219-x86_64.tar.bz2

RUN mkdir -p /opt/blender && \
	curl -SL "$BLENDER_BZ2_URL" -o blender.tar.bz2 && \
	tar -jxvf blender.tar.bz2 -C /opt/blender --strip-components=1 && \
	rm -f blender.tar.bz2

COPY scripts/install_brd.py /opt/scripts/container/
RUN chmod a+rx /opt/scripts/container/install_brd.py

USER ros
RUN sudo /opt/blender/blender -b -noaudio --python /opt/scripts/container/install_brd.py \
    && sudo chown -R ros:ros /home/ros/ \
    && echo 'export PATH=$PATH:/opt/blender/' >> /home/ros/.bashrc

USER root

RUN  chown -R ros:ros /home/ros

# install meshlab
RUN apt-get install -y -q --no-install-recommends meshlab

# install freecad
RUN apt-get install -y -q --no-install-recommends python-software-properties \
    && add-apt-repository -y ppa:freecad-maintainers/freecad-stable \
		&& apt-get update -y && apt-get install -y -q --no-install-recommends freecad freecad-doc \
		&& pip2 install pycollada

# apt-get autoclean
RUN apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /root/.cache
