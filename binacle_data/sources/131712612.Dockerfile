################################################################################
# Copyright (C) 2019 by 52 North                                               #
# Initiative for Geospatial Open Source Software GmbH                          #
#                                                                              #
# Contact: Andreas Wytzisk                                                     #
# 52 North Initiative for Geospatial Open Source Software GmbH                 #
# Martin-Luther-King-Weg 24                                                    #
# 48155 Muenster, Germany                                                      #
# info@52north.org                                                             #
#                                                                              #
# This program is free software; you can redistribute and/or modify it under   #
# the terms of the GNU General Public License version 2 as published by the    #
# Free Software Foundation.                                                    #
#                                                                              #
# This program is distributed WITHOUT ANY WARRANTY; even without the implied   #
# WARRANTY OF MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU #
# General Public License for more details.                                     #
#                                                                              #
# You should have received a copy of the GNU General Public License along with #
# this program (see gpl-2.0.txt). If not, write to the Free Software           #
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA or #
# visit the Free Software Foundation web page, http://www.fsf.org.             #
#                                                                              #
# Author: Jürrens, Eike Hinderk (e.h.juerrens@52north.org)                     #
# Created: 2019-02-27                                                          #
# Project: sos4R - visit the project web page,                                 #
#      http://52north.org/communities/sensorweb/clients/sos4R/                 #
################################################################################
FROM rocker/geospatial:latest
MAINTAINER "Jürrens, Eike Hinderk" e.h.juerrens@52north.org

RUN install2.r --error --skipinstalled XML && \
    install2.r --error --skipinstalled httr && \
    install2.r --error --skipinstalled stringr && \
    install2.r --error --skipinstalled devtools && \
    install2.r --error --skipinstalled webmockr && \
    rm -rf /tmp/downloaded_packages && \
    rm -rf /tmp/repos_*.rds && \
    rm -rf /var/lib/apt/lists/*
