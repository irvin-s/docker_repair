FROM biodepot/nbdocker-rbase:ubuntu_18.04__bioc_3.6__R_3.4.2
MAINTAINER lhhung@uw.edu

RUN R -e "install.packages('Cairo',repos = 'http://cran.us.r-project.org')"
#Set permissions for nbdocker to user
RUN chown -R $NB_USER:$NB_USER /home/$NB_USER
RUN chown -R $NB_USER:$NB_USER /usr/local/rhome

COPY Dockerfiles/scripts/start.sh /usr/local/bin/
COPY Dockerfiles/scripts/start-notebook.sh /usr/local/bin/
COPY Dockerfiles/scripts/start-singleuser.sh /usr/local/bin/

USER $NB_USER

RUN pip3 install --user jupyterhub==0.9.6

ADD nbdocker /home/$NB_USER/nbdocker
ADD setup.py /home/$NB_USER/.
#install nbdocker
RUN cd /home/$NB_USER/ && pip install -e . --user && \
    jupyter serverextension enable --py --user nbdocker && \
    jupyter nbextension install nbdocker --user && \
    jupyter nbextension enable nbdocker/main --user

#install R kernel
RUN R -e "IRkernel::installspec()"

#setup starting enviroinment
WORKDIR /home/$NB_USER/work
RUN echo "options(bitmapType='cairo')" > /home/$NB_USER/.Rprofile
CMD ["/bin/bash", "-c", "sudo chmod 666 /var/run/docker.sock && jupyter notebook --ip 0.0.0.0"]
