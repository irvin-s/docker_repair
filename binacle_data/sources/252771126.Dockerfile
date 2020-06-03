FROM java:8  
COPY PrimeNumber.java /var/www/java/PrimeNumber.java  
WORKDIR /var/www/java  
RUN javac PrimeNumber.java  
CMD ["java", "PrimeNumber"]  

