FROM octohost/php5

RUN echo "<?php phpinfo(); ?>" > /srv/www/phpinfo.php
ADD ./index.php /srv/www/

EXPOSE 80

CMD service php5-fpm start && nginx