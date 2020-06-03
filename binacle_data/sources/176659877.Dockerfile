#------------------------------------------------------------------------------
# Dockerized Redcap for deploying in a variety of environments
#------------------------------------------------------------------------------

#The Containers in the System:
# 1) [afolarin/redcap:mysql] 
# 2) [afolarin/redcap:webapp]
# 3) [afolarin/redcap:cron]

#USAGE (from redcap-docker/db):
# docker run --name="redcap-db" -d -p 3306:3306 afolarin/redcap:mysql; 
# docker logs redcap-db &> mysql.pwd;
# docker inspect --format='{{.NetworkSettings.IPAddress}}' redcap-db &>> mysql.pwd;
# docker inspect --format='{{.NetworkSettings.Ports}}' redcap-db &>> mysql.pwd;

#------------------------------------------------------------------------------
# Database Container: MySQL
#------------------------------------------------------------------------------

FROM tutum/mysql

MAINTAINER Amos Folarin <amosfolarin@gmail.com>


# Use the /run.sh script to create the redcap_admin db user -- should be easy
# it may be necessary to remove the admin db user after all installation is done
# they are required for initial table creation otherwise drop add then drop
# CREAT grants for redcap_admin db user.


