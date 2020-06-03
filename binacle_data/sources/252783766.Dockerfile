# This file is part of the Docker Image for PyThumb.  
# Copyright (C) 2017 Martin Scharm <https://binfalse.de/contact/>  
#  
# This program is free software: you can redistribute it and/or modify  
# it under the terms of the GNU General Public License as published by  
# the Free Software Foundation, either version 3 of the License, or  
# (at your option) any later version.  
#  
# This program is distributed in the hope that it will be useful,  
# but WITHOUT ANY WARRANTY; without even the implied warranty of  
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the  
# GNU General Public License for more details.  
#  
# You should have received a copy of the GNU General Public License  
# along with this program. If not, see <http://www.gnu.org/licenses/>.  
FROM debian:testing-slim  
MAINTAINER martin scharm <https://binfalse.de/contact/>  
  
# install dependencies and update stuff  
# doing all in once to get rid of the useless stuff  
RUN apt-get update \  
&& apt-get upgrade -y -q --no-install-recommends \  
&& mkdir -p /usr/share/man/man1 \  
&& apt-get install -y -q --no-install-recommends \  
python3-pil \  
python3-nose \  
python3-magic \  
python3-requests \  
python3-xvfbwrapper \  
cutycapt \  
libreoffice \  
default-jre \  
ghostscript \  
imagemagick \  
libreoffice-common \  
fonts-droid-fallback \  
&& apt-get clean \  
&& rm -r /var/lib/apt/lists/* /var/cache/*  
  
# copy the tool into the image  
COPY . /pythumb/  
  
WORKDIR /pythumb  
  
# run tests to verify everything is there...  
RUN nosetests3  
  
ENTRYPOINT ["python3", "/pythumb/pythumb/server.py"]  
CMD ["--port", "80", "--ip", "0.0.0.0"]  

