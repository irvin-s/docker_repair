FROM bretfisher/stress:latest

CMD ["stress", "--verbose", "--vm", "1", "--vm-bytes", "512M"]
