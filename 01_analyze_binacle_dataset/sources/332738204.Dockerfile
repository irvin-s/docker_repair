from debian:wheezy

run apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
run apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    make \
    zip \
    && apt-get -y clean

run echo "deb https://download.mono-project.com/repo/debian wheezy/snapshots/3.12/. main" | tee /etc/apt/sources.list.d/mono-official-stable.list
run apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    monodevelop \
    && apt-get -y clean

run apt-mark hold monodevelop
#env MONO_PATH=/usr/lib/mono/3.5

workdir /mnt/kerbalmod
cmd make
