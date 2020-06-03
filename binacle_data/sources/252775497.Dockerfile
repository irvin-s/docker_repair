FROM grafana/grafana  
MAINTAINER Ben Dews, bendews  
  
RUN groupmod -g 110 users \  
&& groupmod -g 100 grafana \  
&& usermod -u 1024 grafana \  
#&& `find / -user 104 -exec chown -h 1000 {} \;` \  
#&& `find / -group 107 -exec chgrp -h 1000 {} \;` \  
&& usermod -g 100 grafana \  
&& chown -R grafana:grafana /var/lib/grafana

