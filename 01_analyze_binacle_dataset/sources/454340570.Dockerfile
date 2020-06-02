FROM monetas/ot-android-dev

MAINTAINER Filip Gospodinov "filip@monetas.net"

ENV OT_PATH /home/otuser/opentxs-source

ADD CMakeLists.txt .clang-format .gitignore .gitmodules $OT_PATH/
ADD cmake $OT_PATH/cmake
ADD deps $OT_PATH/deps
ADD scripts $OT_PATH/scripts
ADD tests $OT_PATH/tests
ADD wrappers $OT_PATH/wrappers
ADD include $OT_PATH/include
ADD .git $OT_PATH/.git
ADD src $OT_PATH/src

WORKDIR /home/otuser/ot-android/
RUN ./run-build.sh
CMD uid=$(ls -ldn /mnt/ | awk '{print $3}') && install -o $uid -g $uid opentxs-*.tar.bz2 /mnt/
