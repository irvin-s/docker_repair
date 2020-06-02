# dockerfile for all composer related tools and composer-playground
# Copyright (C) 2017 Suen Chun Hui

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
FROM hyperledger/fabric-tools:x86_64-1.0.0
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update ; apt-get install -y python ; npm install -g composer-cli@0.16.3 composer-playground@0.16.3 pm2 composer-rest-server@0.16.3
