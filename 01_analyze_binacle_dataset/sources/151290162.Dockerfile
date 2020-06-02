FROM silarsis/ssh-server
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
# Install a user, move the ssh key across
RUN adduser --disabled-password --gecos "" jenkins
RUN mv /root/.ssh /home/jenkins/.ssh && chown -R jenkins.jenkins /home/jenkins/.ssh