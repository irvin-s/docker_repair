FROM node:5  
  
# node:5 with jdk installed (to run closure)  
# This is just to support sjcl's need for closure  
RUN apt-get update && apt-get install -y openjdk-7-jdk  
  
CMD [ "node" ]

