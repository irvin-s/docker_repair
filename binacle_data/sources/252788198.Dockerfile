from crhan/anaconda3  
maintainer ruohan.chen <crhan123@gmail.com>  
  
RUN conda create -n pyannote python=3.5 anaconda -y  
RUN source activate pyannote; \  
conda install -c menpo cmake gcc ffmpeg=3.1.3 opencv boost -y  
RUN source activate pyannote; \  
pip install pyannote-video  
RUN echo "source activate pyannote" >> /root/.bashrc  
ADD ./jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py  
ADD run.sh /root/run.sh  
RUN mkdir /opt/notebook  
  
add ./fix_current_prob.sh /root/fix_current_prob.sh  
run bash /root/fix_current_prob.sh  
  
WORKDIR /opt/notebook  
CMD ["/root/run.sh"]  
  

