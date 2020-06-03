# gnuhealth-demo 2.8  
FROM mbsolutions/tryton-server-gnuhealth:3.4  
MAINTAINER Simon Vass <billynkid@gmail.com>  
  
ENV TRYTOND_DATABASE_URI=postgres://gnuhealthdb.gnuhealth.local:5432  
ADD run.sh /  
CMD ./run.sh && tail -f /dev/null  
  

