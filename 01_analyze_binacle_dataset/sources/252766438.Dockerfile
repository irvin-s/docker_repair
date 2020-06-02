FROM node:0.10.38  
RUN apt-get update && apt-get install -y \  
python3-pip  
  
RUN npm install -g bower gulp  
  
CMD ["bash"]  

