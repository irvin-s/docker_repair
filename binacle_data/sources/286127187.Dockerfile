FROM python:2.7
RUN apt-get -y update && apt-get install -y software-properties-common vim git ntp ntpdate python-opencv 
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN mkdir ~/.aws && echo "[default]" >> ~/.aws/config && echo "region=us-east-1" >> ~/.aws/config
RUN echo "[default]" >> ~/.aws/credentials
RUN echo export TERM='xterm-256color' >> ~/.bashrc
RUN echo export TERM='xterm-256color' >> ~/.profile
WORKDIR ~/
RUN git clone https://github.com/troylar/myvimrc.git myvimrc &&  cp myvimrc/.vimrc ~ 
RUN cp -r myvimrc/.vim ~
RUN cp -r myvimrc/.vim_runtime ~
RUN service ntp restart
RUN pip install virtualenv
RUN virtualenv venv
RUN source ./venv/bin/activate
#RUN pip install -r requirements.txt
# for a flask server
WORKDIR /mnt
ENV PATH="./mnt/vender/bin:${PATH}"
RUN usermod -a -G audio root
EXPOSE 5000
CMD ["python", "hello_world.py"]
