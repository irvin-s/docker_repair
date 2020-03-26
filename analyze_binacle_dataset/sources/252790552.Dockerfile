FROM carllhw/odoo-env:9.0  
LABEL maintainer="Haiwei Liu <carllhw@gmail.com>"  
  
COPY ./requirements.txt /usr/src/odoo/  
RUN pip install --no-cache-dir -r /usr/src/odoo/requirements.txt  
  
RUN mkdir /var/lib/odoo && chown odoo:odoo /var/lib/odoo  
  
EXPOSE 8069 8071  
VOLUME ["/var/lib/odoo"]  
  
USER odoo  

