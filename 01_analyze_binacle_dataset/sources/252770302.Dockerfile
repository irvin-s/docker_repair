# Base  
FROM mysql  
  
# Install wget  
RUN apt-get -y update \  
&& apt-get -y upgrade \  
&& apt-get install -y wget  
  
# Add load_cb_data files  
RUN mkdir -p /home/loader/  
ADD load_cb_data.sh /home/loader/load_cb_data.sh  
ADD load_cb_data.sql /home/loader/load_cb_data.sql  
  
# Make /home/loader/load_cb_data.sh executable  
RUN chmod +x /home/loader/load_cb_data.sh  
CMD ["/home/loader/load_cb_data.sh"]  

