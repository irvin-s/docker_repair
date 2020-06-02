FROM kylef/swiftenv:1
MAINTAINER Kyle Fuller <kyle@fuller.li>

# Install swift build dependencies
RUN apt-get -qq -y install cmake ninja-build python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config
