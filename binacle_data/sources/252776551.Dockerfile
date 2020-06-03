FROM python:2.7  
RUN sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list  
  
RUN apt-get update && apt-get install -y --no-install-recommends graphviz \  
&& apt-get autoclean -y \  
&& apt-get -y update && apt-get install -y \  
&& apt-get clean -y \  
&& mkdir /transform \  
&& mkdir /data  
RUN apt-get install openjdk-7-jdk -y  
RUN apt-get install ant-contrib -y  
RUN export CLASSPATH=/usr/share/java/ant-contrib.jar  
RUN pip install sphinx sphinxcontrib-argdoc  
  
ADD . /ddi-views  
ADD ./buildsystem/lib/saxon9he.jar /usr/share/java/Saxon9he.jar  
WORKDIR /ddi-views/buildsystem/ant

