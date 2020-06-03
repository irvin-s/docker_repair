# This file is part of TorreArchimedeBot.
#
# TorreArchimedeBot is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# TorreArchimedeBot is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with TorreArchimedeBot.  If not, see <http://www.gnu.org/licenses/>.

FROM python:3.6-slim

MAINTAINER Davide Polonio <poloniodavide@gmail.com>
LABEL A simple bot to see Torre Archimede room scheduling

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD [ "python", "./torrearchimedebot/" ]
