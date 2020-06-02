# ====================================================================== #  
# Python CI Docker Image  
# ====================================================================== #  
# Base image  
# ---------------------------------------------------------------------- #  
FROM python:3.6.4-stretch  
LABEL MAINTAINER="Ivan <aoach.public@gmail.com>"  
  
# Container settings  
# ---------------------------------------------------------------------- #  
WORKDIR /root  
ENV LC_ALL C.UTF-8  
ENV LANG =C.UTF-8  
# Install twine so you can upload package to pypi!  
COPY requirements.txt requirements.txt  
RUN pip install -r requirements.txt \  
&& rm -rf requirements.txt  
  
CMD ["/bin/bash"]  

