from fedora:26
run mkdir -p /projects
workdir /projects
run dnf install -y gdb \
    http://eclipseice.ornl.gov/downloads/xacc/rpms/x86_64/fc26/xacc-1.0-1.fc26.x86_64.rpm \
    https://github.com/ORNL-QCI/ScaffCC/releases/download/v2.0/scaffold-2.0-1.fc26.x86_64.rpm 

