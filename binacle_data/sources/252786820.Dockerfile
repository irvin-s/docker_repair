  
FROM nicholsn/niquery  
MAINTAINER bowwow <bowwow@gmail.com>  
  
RUN pip install flower redis  
  
EXPOSE 5555  
ADD run.sh run.sh  
RUN chmod +x run.sh  
CMD ./run.sh

