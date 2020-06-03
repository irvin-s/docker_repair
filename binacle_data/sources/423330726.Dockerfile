FROM jcscottiii/base-gui-gdec:latest
MAINTAINER James C. Scott III <jcscott.iii@gmail.com>

# Change to root to install more dependencies
USER root
# Make sure to download newer version of node than what is the default in apt-get
# Install other dependencies
RUN apt-get install -y \
    curl=7.35.0-1ubuntu2.5
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN apt-get install -y \
    nodejs=5.1.1-1nodesource1~trusty1 \
    zip=3.0-8

RUN apt-get clean

# Change back to non-root user
USER $USERNAME

# Switch npm prefix to prevent using sudo.
RUN mkdir $HOME/.npm-global
ENV NPM_CONFIG_PREFIX $HOME/.npm-global
ENV PATH $HOME/.npm-global/bin:$PATH

# Install VSCode
RUN wget -O $HOME/VSCode.zip 'https://az764295.vo.msecnd.net/public/0.10.3/VSCode-linux64.zip'
RUN unzip $HOME/VSCode.zip -d $HOME/vscode/
RUN ln -s $HOME/vscode/VSCode-linux-x64/Code $HOME/bin/code
# Install vsce, the Visual Studio Extension Manager
RUN npm install -g vsce
# Install the vscode-go extension
RUN git clone https://github.com/Microsoft/vscode-go $HOME/.vscode/extensions/lukehoban.Go && cd $HOME/.vscode/extensions/lukehoban.Go && git checkout tags/0.6.17 && npm install && vsce package

# Add settings.json file that contains settings for the go extension
RUN mkdir -p $HOME/.config/Code/User/
ADD settings.json $HOME/.config/Code/User/settings.json

# Move back to root for the su in entry.sh
USER root

# chown the settings.json file to the non-root user
RUN chown -R $USERNAME:$USERNAME $HOME/.config/Code/User/settings.json
