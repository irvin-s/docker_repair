FROM alpine:edge  
# edgeじゃないとChromiumのバージョンが57  
RUN apk --no-cache add chromium chromium-chromedriver udev ttf-freefont tshark  
  
COPY headless-chrome.sh /headless-chrome  
RUN chmod +x /headless-chrome  
ENTRYPOINT [ "/headless-chrome" ]

