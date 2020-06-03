FROM python:3  
RUN apt-get update  
RUN apt-get install --assume-yes vim microcom  
RUN pip3 install filemagic  
  
RUN git clone https://github.com/labgrid-project/labgrid /opt/labgrid  
RUN cd /opt/labgrid && python3 setup.py install  
  
RUN echo '#!/bin/bash' > /opt/entry_script.sh  
RUN echo '/bin/bash' >> /opt/entry_script.sh  
RUN chmod a+x /opt/entry_script.sh  
ENTRYPOINT ["/opt/entry_script.sh"]  
  

