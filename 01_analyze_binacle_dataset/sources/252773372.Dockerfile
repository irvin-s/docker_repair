from simexp/niak-cog  
  
RUN apt-get install -y\  
python-setuptools python-dev &&\  
easy_install pip &&\  
mkdir /test && mkdir /ovmc  
  
ADD bin/mcflirt /bin  
ADD test/data/test.nii.gz /test  
ADD ovmc /ovmc/ovmc  
ADD setup.py /ovmc  
RUN (cd /ovmc && ls && pip install .)  

