#  
# Geckodriver Dockerfile  
#  
  
FROM blueimp/basedriver  
  
# Install Firefox:  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get install --no-install-recommends --no-install-suggests -y \  
firefox-esr \  
# Remove obsolete files:  
&& apt-get clean \  
&& rm -rf \  
/tmp/* \  
/usr/share/doc/* \  
/var/cache/* \  
/var/lib/apt/lists/* \  
/var/tmp/*  
  
# Install geckodriver:  
RUN export BASE_URL=https://github.com/mozilla/geckodriver/releases/download \  
&& export VERSION=$(curl -sL \  
https://api.github.com/repos/mozilla/geckodriver/releases/latest | \  
grep tag_name | cut -d '"' -f 4) \  
&& curl -sL \  
$BASE_URL/$VERSION/geckodriver-$VERSION-linux64.tar.gz | tar -xz \  
&& mv geckodriver /usr/local/bin/geckodriver  
  
USER webdriver  
  
CMD ["geckodriver", "--host", "0.0.0.0"]  

