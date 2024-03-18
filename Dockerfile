# Use offical tomcat runtime as a parent image
FROM FROM tomcat:9.0-jdk15

# Copy the war file into container
COPY SurveyForm.war /usr/local/tomcat/webapps/

#Expose port 8080 for container
EXPOSE 8080

#start tomcat servr
CMD ["catalina.sh", "run"]
