FROM python:2.7.13-wheezy  
  
MAINTAINER laurens.rietveld@vu.nl  
  
ENV INSPECTOR_APP="/usr/local/inspector"  
COPY ./requirements.txt /requirements.txt  
RUN pip install -r requirements.txt  
  
COPY ./src ${INSPECTOR_APP}  
ENV CONFIG_FILE=${INSPECTOR_APP}/app/config.py  
RUN cp ${INSPECTOR_APP}/app/config_template.py ${CONFIG_FILE}  
  
COPY entrypoint.sh /sbin/entrypoint.sh  
RUN chmod 755 /sbin/entrypoint.sh  
  
WORKDIR ${INSPECTOR_APP}  
ENTRYPOINT ["/sbin/entrypoint.sh"]  
CMD ["app:start"]  
EXPOSE 5500  

