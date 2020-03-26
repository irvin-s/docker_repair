# BUILDAS docker build -t acuitra-website .
# RUNAS docker run -p 80:80 -v ~/Acuitra/services/frontend-web/:/var/www -d acuitra-website

FROM orchardup/nginx
MAINTAINER Nick Lothian "nick.lothian@gmail.com"

# In docker v0.7.5 this gives the following error
# Forbidden path outside the build context: ../../services/frontend-web/ (/services/frontend-web)
#ADD ../../services/frontend-web/ /var/www

#
# To work around that, mount that directory at run time
# using the argument -v ~/Acuitra/services/frontend-web/:/var/www
#
# Yes, this goes against the Docker documentation. Once the bug is fixed this can be avoided
#

CMD 'nginx'
