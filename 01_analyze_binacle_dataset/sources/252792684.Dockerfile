FROM tensorflow/tensorflow:latest-py3  
  
# COPYING ML  
WORKDIR /ml  
COPY . /ml  
  
# INSTALLING DEPENDENCIES  
RUN pip install -r requirements.txt  
  
RUN rm /*.whl; \  
rm -rf /notebooks/*;  
  
ENV PATH="/ml:${PATH}"  
# RUN THE TRAINING  
CMD [ "train.sh" ]  

