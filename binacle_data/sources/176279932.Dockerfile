# version 1 - WebSphere for Developers install on a docker container. The base image used already contains Installation Manager installed. Check my previous post to
# see how the base image was generated: https://www.ibm.com/developerworks/community/blogs/devTips/entry/ibm_installation_manager_in_silent_mode_no_x_on_linux_quick_reference?lang=en
# WebSphere for developer can be downloaded from IBM web site: http://www.ibm.com/developerworks/downloads/ws/wasdevelopers/
# by mmaia - mpais@br.ibm.com, maia.marcos@gmail.com
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# +------------------------------------------------------------------------+
# | Licensed Materials - Property of IBM                                   |
# | (C) Copyright IBM Corp. 2010, 2011.  All Rights Reserved.              |
# |                                                                        |
# | US Government Users Restricted Rights - Use, duplication or disclosure |
# | restricted by GSA ADP Schedule Contract with IBM Corp.                 |
# +------------------------------------------------------------------------+
#
# To build this image run a command like the following:
# docker build -t="mmaia/was-dev:v1" .
#
# Than you can run the container for the first time using:
# docker run -i -t -p 9080:9080 -p 9060:9060 --name mmaia-was-dev mmaia/was-dev:v1 /bin/bash
# the command above creates the image with the name mmaia-was-dev, you can change it to whatever you want.
#
# Once you've runned the container and it's already created, use start instead of run.(replace the $CONTAINER_NAME) with
# the name you have picked during the run command above.
# docker start $CONTAINER_NAME /bin/bash
#
# and if needed to attach to the running container
# docker attach $CONTAINER_NAME

FROM mmaia/im_ibm:v1
MAINTAINER Marcos Maia "mpais@br.ibm.com / maia.marcos@gmail.com"

#copy files to docker image
COPY *.zip tmp/

# preparing the files to install, unzipping and creating correct directory structures for WAS  and deleting the
# zip files that are not necessary anymore so disk image doesn't get without space (docker limit to 10GB by now)
RUN cd tmp && mkdir was && unzip was_part1.zip -d was && rm -rf was_part1.zip && unzip was_part2.zip -d was  \
    && rm -rf was_part2.zip && unzip was_part3.zip -d was && rm -rf was_part3.zip

# now that WAS dev is ready to be installed by IBM Installation manager we need to execute the I.M command to install it
# we're going to use a silent installation file to accomplish that so we copy a response file to configure the installation
# to the tmp directory in the docker image
COPY install_response_file.xml tmp/install_response_file.xml

# now we execute the installation manager instruction to use this response file and the was repo we've created and execute the installation.
# and than when the installation is done we delete the repository so the image doesn't get tooooo big(it's big anyway :) )
RUN cd /opt/IBM/InstallationManager/eclipse/tools && ./imcl -acceptLicense input /tmp/install_response_file.xml -log /tmp/install_log.xml
RUN rm -rf tmp/was && rm -rf tmp/install_response_file.xml

# now we're going to create a default profile(USING ALL DEFAULT) so we can finally plan on running WAS DEV in this image...
# this will create a profile named AppSrv01 under AppServer/profiles directory...
RUN /opt/IBM/WebSphere8.5.5_Dev/AppServer/bin/manageprofiles.sh -create -templatePath /opt/IBM/WebSphere8.5.5_Dev/AppServer/profileTemplates/default

# Let's expose at least HTTP and Dmgr(Admin) ports for this profile
EXPOSE 9080 9060

# Make sure WAS will be started any time we start docker container with /bin/bash support.
COPY startWAS.sh etc/profile.d/startWAS.sh