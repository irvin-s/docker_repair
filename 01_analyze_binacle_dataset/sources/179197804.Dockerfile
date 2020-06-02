FROM andmos/mono-pcl

ADD bin bin

CMD mono /bin/Debug/TestHealthRecordServer.Console.exe $URL 

