FROM ubuntu:16.04

#* Put thimblerig.service and thimblerig.socket in /etc/systemd/system/
#* Create the user and group "griftah"
#* Put the "flag" and "thimblerig" files in /home/griftah
#* chmod 750 /home/griftah/thimblerig
#* chmod 640 /home/griftah/flag
#* chown -R root:griftah /home/griftah
#* chmod 750 /home/griftah
#Should be able to connect to the service on port 19227. The exploit.py should be able to get the flag at least 10% of the time on decent hardware.

RUN sed -i 's/archive/us.archive/g' /etc/apt/sources.list
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y build-essential socat libc6:i386 libstdc++6:i386

#Setting user griftah
RUN adduser --disabled-password --gecos '' griftah
RUN chown -R root:griftah /home/griftah/
RUN chmod 750 /home/griftah/ 

#Copying files
WORKDIR /home/griftah
COPY thimblerig.service /etc/systemd/system/
COPY thimblerig.socket /etec/systemd/system/
COPY thimblerig ./
COPY flag ./

RUN chmod 640 flag
RUN chmod 750 thimblerig

CMD ["socat", "TCP-LISTEN:4242,reuseaddr,fork", "EXEC:/home/griftah/thimblerig"]
