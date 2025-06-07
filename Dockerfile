FROM tomcat:9.0-jdk11
COPY target/ABCtechnologies-1.0.war /usr/local/tomcat/webapps/ABCtechnologies.war
CMD ["catalina.sh", "run"]
