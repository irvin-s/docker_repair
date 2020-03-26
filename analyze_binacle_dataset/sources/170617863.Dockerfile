# This file is part of Miasm2-Docker.
# Copyright 2014 Camille MOUGEY <commial@gmail.com>
#
# Miasm2-Docker is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Miasm2-Docker is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
# License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Miasm2-Docker. If not, see <http://www.gnu.org/licenses/>.

FROM miasm/base:latest
MAINTAINER Camille Mougey <commial@gmail.com>

# Launch tests
RUN /usr/bin/python test_all.py -m

# Default command
CMD ["/bin/bash"]