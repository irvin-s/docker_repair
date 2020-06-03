FROM continuumio/miniconda:latest  
RUN conda create -n img-proc python=3.6 -y  
ENV BINWORKDIR=/opt/conda/envs/img-proc/bin  
RUN $BINWORKDIR/pip install image  
WORKDIR /opt/conda/envs/img-proc/bin  
COPY ./invertImage.py $BINWORKDIR/invertImage.py  
ENTRYPOINT ["./python", "invertImage.py"]  
CMD ["0"]

