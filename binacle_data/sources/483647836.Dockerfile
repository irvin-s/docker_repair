FROM ubuntu:latest

RUN apt-get install -y wget ruby ruby-dev
RUN wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
RUN sudo dpkg -i puppetlabs-release-trusty.deb
RUN sudo apt-get update

RUN sudo apt-get install -y puppetmaster
RUN gem install serverspec