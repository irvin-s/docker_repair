# This file is part of the Docker Image for a Docker:Git-Pull.  
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
MAINTAINER martin scharm  
  
# doing all in once to get rid of the useless stuff  
RUN apt-get update \  
&& apt-get install -y -q --no-install-recommends \  
git \  
ca-certificates \  
&& apt-get clean \  
&& rm -r /var/lib/apt/lists/* /var/cache/*  
  
VOLUME ["/git-project"]  
WORKDIR /git-project  
  
COPY git-pull /usr/local/bin/git-pull  
ENTRYPOINT ["/usr/local/bin/git-pull"]  

