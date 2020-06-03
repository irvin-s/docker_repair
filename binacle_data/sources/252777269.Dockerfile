FROM ceshine/py2-datascience-toolbox:latest  
MAINTAINER CeShine Lee, ceshine@ceshine.net  
  
# Persist notebook changes across containers  
VOLUME ["/lab"]  
  
ADD . /lab  
  

