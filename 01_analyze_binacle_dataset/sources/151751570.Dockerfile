FROM mafintosh/dev
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main" >> /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get update
RUN apt-get install -yq  mono-complete unzip
RUN curl https://raw.githubusercontent.com/aspnet/Home/master/kvminstall.sh | sh && mozroots --import --sync
ADD k kpm-restore kvm-upgrade /bin/
RUN kvm-upgrade

ONBUILD ADD project.json /root/project.json
ONBUILD RUN kpm-restore
ONBUILD ADD . /root/

ENTRYPOINT ["/bin/k"]
