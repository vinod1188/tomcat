FROM ubuntu:latest
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install openjdk-11-jdk -y
RUN apt-get install wget -y
RUN mkdir /usr/local/tomcat
RUN cd /tmp && wget  https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.19/bin/apache-tomcat-10.1.19.tar.gz && tar -xvf apache-tomcat-10.1.19.tar.gz
RUN cp -Rv /tmp/apache-tomcat-10.1.19 /usr/local/tomcat/
COPY tomcat-users.xml /usr/local/tomcat/apache-tomcat-10.1.19/conf/tomcat-users.xml
EXPOSE 8080
CMD /usr/local/tomcat/apache-tomcat-10.1.19/bin/catalina.sh run

