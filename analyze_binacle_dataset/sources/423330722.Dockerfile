FROM jcscottiii/base-gui-gdec:latest
MAINTAINER James C. Scott III <jcscott.iii@gmail.com>

# Install additional libs
RUN apt-get install -y \
    openjdk-7-jre \
    openjdk-7-jdk \
    zenity \
    zip=3.0-8
RUN apt-get clean

USER $USERNAME

RUN wget -O $HOME/IdeaIC.tar.gz 'https://d1opms6zj7jotq.cloudfront.net/idea/ideaIC-15.0.1.tar.gz'
RUN mkdir $HOME/intellij && tar -xzf $HOME/IdeaIC.tar.gz -C $HOME/intellij/ --strip-components=1
RUN ln -s $HOME/intellij/bin/idea.sh $HOME/bin/idea.sh

# Get plugin version from here: https://plugins.jetbrains.com/plugin/5047
# Current version is 0.10.749
RUN wget -O $HOME/Go-Plugin.zip 'https://plugins.jetbrains.com/plugin/download?pr=&updateId=22601'
RUN unzip $HOME/Go-Plugin.zip -d $HOME/intellij/plugins/

# Make sure to use $HOME/.IdeaIC and not $HOME/IdeaICvXY
RUN grep '# idea.config.path=${user.home}\/.IdeaIC\/config' $HOME/intellij/bin/idea.properties && \
    sed -i 's/# idea.config.path=${user.home}\/.IdeaIC\/config/idea.config.path=${user.home}\/.IdeaIC\/config/g' $HOME/intellij/bin/idea.properties
# Add config files
RUN mkdir -p $HOME/.IdeaIC/config/options/
ADD recentProjects.xml $HOME/.IdeaIC/config/options/recentProjects.xml
ADD jdk.table.xml $HOME/.IdeaIC/config/options/jdk.table.xml

# Move back to root for the su in entry.sh
USER root

# Chown the settings files to non-root user.
RUN chown -R $USERNAME:$USERNAME $HOME/.IdeaIC/config/options/recentProjects.xml
RUN chown -R $USERNAME:$USERNAME $HOME/.IdeaIC/config/options/jdk.table.xml

