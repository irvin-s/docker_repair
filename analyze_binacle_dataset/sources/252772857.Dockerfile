FROM python:3  
RUN git clone https://github.com/linickx/crassh.git  
WORKDIR crassh  
RUN /bin/bash -c "pip install -r requirements.txt"  
CMD ["python", "crassh.py"]  

