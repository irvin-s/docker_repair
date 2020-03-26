#Move this to puppet when possible  
from ubuntu:15.10  
env DB_USER / wailer  
env DB_PASSWORD / missing_complaint  
env DB_URL / jdbc:postgresql://localhost/wailings  
  
CMD apt-get update -y && apt-get install maven  
  
VOLUME /var/www/wailer  
  
add . /var/www/wailer

