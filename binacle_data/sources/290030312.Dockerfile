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
FROM fabric-composer-tools

RUN git clone https://github.com/IBM-Blockchain/marbles.git -b v4.0 ; cd marbles ; npm install -g gulp ; npm install 