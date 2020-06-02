FROM    ubuntu:14.04

RUN     sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN     echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list

RUN     apt-get update
RUN     apt-get install -y -q mono-complete

RUN     useradd -m linq

ADD     flag.txt /home/linq
ADD     linq_to_the_present/bin/Release/linq_to_the_present.exe /home/linq
ADD     linq_to_the_present/bin/Release/System.Linq.Dynamic.dll /home/linq

EXPOSE  8888
CMD     ["su", "-m", "linq", "-c", "mono /home/linq/linq_to_the_present.exe"]

