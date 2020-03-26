### Created by Dr. Benjamin Richards (b.richards@qmul.ac.uk)  
### Download base image from repo  
FROM anniesoft/toolanalysis:base-light  
  
### Run the following commands as super user (root):  
USER root  
  
Run cd ToolAnalysis; bash -c "source Setup.sh; make update; make;"  
### Open terminal  
CMD ["/bin/bash"]  

