FROM debian:9

#Mrtrix
RUN apt-get update && apt-get install -y wget git g++ python python-numpy libeigen3-dev zlib1g-dev libqt4-opengl-dev libgl1-mesa-dev libfftw3-dev libtiff5-dev dc
RUN cd /opt && git clone https://github.com/MRtrix3/mrtrix3.git
RUN cd /opt/mrtrix3 && export EIGEN_CFLAGS="-isystem /usr/include/eigen3" && ./configure
RUN cd /opt/mrtrix3 && NUMBER_OF_PROCESSORS=1 ./build


#Freesurfer
RUN apt-get install -y tcsh bc libgomp1 perl-modules
RUN mkdir /opt/freesurfer-stable && wget -N -qO- ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz | tar -xzv -C /opt/freesurfer-stable
COPY license.txt /opt/freesurfer-stable/freesurfer/license.txt
ENV FREESURFER_HOME /opt/freesurfer-stable/freesurfer


#FSL
RUN wget https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py
RUN echo "" | python fslinstaller.py
ENV FSLDIR /usr/local/fsl
RUN . ${FSLDIR}/etc/fslconf/fsl.sh
ENV PATH ${FSLDIR}/bin:${PATH}


#Anaconda
RUN apt-get update && apt-get install -y bzip2
RUN wget --quiet --output-document=anaconda.sh "https://repo.continuum.io/archive/Anaconda2-5.1.0-Linux-x86_64.sh" && sh anaconda.sh -b -p /opt/conda
ENV PATH /opt/conda/bin:${PATH}


#Pegasus and HTCondor
RUN apt-get update && apt-get install -y gnupg
RUN wget -O - http://download.pegasus.isi.edu/pegasus/gpg.txt | apt-key add -
RUN echo 'deb http://download.pegasus.isi.edu/pegasus/debian stretch main' >/etc/apt/sources.list.d/pegasus.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y condor && apt-get install -y pegasus

RUN echo "DISCARD_SESSION_KEYRING_ON_STARTUP=False\n" >> /etc/condor/condor_config.local
RUN echo "USE_PROCD = False\n" >> /etc/condor/condor_config.local
RUN mkdir /opt/pegasus-run && mkdir /opt/pegasus-run/submit && mkdir /opt/pegasus-run/scratch


#Prepare submitter user for HTCondor
RUN apt-get install -y sudo vim
ENV SUBMIT_USER submitter
ENV GID 1000
ENV UID 1000
ENV PASS 123456

RUN groupadd -g ${GID} ${SUBMIT_USER} && \
    useradd -m -u ${UID} -g ${GID} ${SUBMIT_USER} && \
    usermod -a -G condor ${SUBMIT_USER} && \
    usermod -a -G sudo ${SUBMIT_USER} && \
    echo ${SUBMIT_USER}:${PASS} | chpasswd #&& \
RUN sed -i 's/\(^Defaults.*requiretty.*\)/#\1/' /etc/sudoers
RUN chown -R ${SUBMIT_USER}:${SUBMIT_USER} /home/${SUBMIT_USER}
RUN chmod -R 777 /home/${SUBMIT_USER}

RUN chown -R ${SUBMIT_USER}:${SUBMIT_USER} /opt/pegasus-run
RUN chmod -R 777 /opt/freesurfer-stable/freesurfer/subjects
RUN chmod -R 777 /opt/freesurfer-stable/freesurfer/bin
RUN sudo ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh