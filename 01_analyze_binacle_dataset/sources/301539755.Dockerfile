#  this file is part of Devsus.
#
#  Copyright 2018, 2019 Dima Krasner
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.

FROM dyne/devuan:ascii

RUN apt-get -qq update && apt-get upgrade -y && apt-get install -y --no-install-recommends --no-install-suggests ca-certificates git gcc libc-dev bc gcc-arm-none-eabi make xz-utils patch device-tree-compiler wget u-boot-tools vboot-kernel-utils debootstrap kmod m4 cmake bzip2 g++ parted cgpt e2fsprogs ccache && apt-get autoremove --purge && apt-get autoclean
