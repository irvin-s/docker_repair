FROM boinc/server_apache:3.0.0-b2d-defaultargs

MAINTAINER Marius Millea <mariusmillea@gmail.com>

# install packages 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python-certbot-apache \
        python-matplotlib \
        python-mysqldb \
        python-numpy \
        python-scipy \
        python-yaml \
        vim \
    && rm -rf /var/lib/apt/lists

RUN a2enmod ssl

# get xkcd font
RUN curl -L http://antiyawn.com/uploads/Humor-Sans-1.0.ttf > /usr/share/matplotlib/mpl-data/fonts/ttf/Humor-Sans.ttf

RUN rm /etc/apache2/sites-enabled/000-default.conf

COPY supervisor.cosmohome.conf /etc/supervisor/conf.d
