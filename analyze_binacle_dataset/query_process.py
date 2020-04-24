#Import urlib for URL requests
import urllib.request

#Function to read log file last lines
def lastNlines(f,n):
    with f as file:
        for line in (file.readlines()[-n:]):
            lines = line
    return lines

#Read log file
log_file = open("logs/fail/484144517.log","r")
result = lastNlines(log_file,3)
print(result)

#Send the error log to google
webUrl = urllib.request.urlopen('http://www.google.com.')
#print("result code: " + str(webUrl.getcode()))

#Show the google query result
data = webUrl.read()
#print(data)