FROM bmedora/vropscli-build-tools:latest
WORKDIR vropscli

# copy the local repo
COPY . .

# install required modules
RUN \
    export LD_LIBRARY_PATH=/usr/local/lib${LD_LIBRARY_PATH} && \
    pip3 install \
        pyinstaller \
        certifi \
        chardet \
        click \
        fire \
        idna \
        itsdangerous \
        Jinja2 \
        MarkupSafe \
        pyyaml \
        requests \
        urllib3 \
        Werkzeug \
        dateparser \
        six

# build single executable
RUN \
    export LD_LIBRARY_PATH=/usr/local/lib${LD_LIBRARY_PATH} && \
    pyinstaller -F vropscli.py
