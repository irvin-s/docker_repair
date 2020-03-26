FROM python:3.6  
RUN pip install selenium==3.3.0  
RUN pip install behave  
RUN pip install browserstack-local  
RUN pip install paver  
RUN pip install psutil  
  
RUN useradd -u 1000 -m -s /bin/bash -G sudo tests && \  
passwd -d tests  
  
USER tests  
WORKDIR /home/tests  
COPY . /home/tests  
  
ENV ON_DOCKER true  
  
ENTRYPOINT "/bin/bash"  
CMD paver run  

