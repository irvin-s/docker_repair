FROM python:3  
RUN pip install pyyaml  
  
RUN mkdir /app/  
RUN mkdir /app/indir/  
RUN mkdir /app/outdir/  
  
COPY . /app  
  
#Whatever we do, we need to run python  
ENTRYPOINT ["python"]  
  

