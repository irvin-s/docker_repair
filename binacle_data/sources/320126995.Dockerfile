FROM centos:centos7

ARG user

RUN yum --assumeyes update \
    && yum --assumeyes install \
         @'Development Tools' \
         glibc-static \
         libstdc++-static \
         cmake \
         docbook-dtds \
         man-db \
         perl-ExtUtils-MakeMaker \
         pexpect \
         python \
         sudo \
    && yum clean all

RUN useradd $user --create-home
RUN useradd testuser --create-home # To test if the binaries are hardcoded to the build user's path
RUN echo "$user ALL=(ALL) NOPASSWD: ALL" | EDITOR='tee -a' visudo
USER $user
WORKDIR /home/$user
ENV PATH /home/$user/.local/bin:$PATH
