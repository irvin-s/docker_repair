FROM microsoft/windowsservercore



ENTRYPOINT ["ping","-4"]


CMD ["localhost"]

