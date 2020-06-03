FROM phpmyadmin/phpmyadmin:latest  
  
COPY common.inc.php /www/libraries/common.inc.php  
COPY session.inc.php /www/libraries/session.inc.php  
COPY config.inc.php /www/config.inc.php

