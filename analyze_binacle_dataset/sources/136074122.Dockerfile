FROM lyapi-baseimage:latest
MAINTAINER Lien Chiang <xsoameix@gmail.com>

# workers
ADD lib app/lib
ADD populate-calendar.ls /app/populate-calendar.ls
ADD calendar-sitting.ls /app/calendar-sitting.ls
ADD ys-misq.ls /app/ys-misq.ls
ADD bill-details.ls /app/bill-details.ls
