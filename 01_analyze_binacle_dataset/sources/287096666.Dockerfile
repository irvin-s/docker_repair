FROM lambci/lambda:build-nodejs6.10
RUN curl https://raw.githubusercontent.com/jamesob/desk/master/desk > /usr/local/bin/desk \
    && chmod +x /usr/local/bin/desk
# TODO: Switch to https://yarnpkg.com/en/docs/install#linux-tab
RUN npm install -g yarn claudia
ENTRYPOINT ["bash"]
CMD ["-c", "source Deskfile && exec bash"]
