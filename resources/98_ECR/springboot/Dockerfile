FROM adoptopenjdk/openjdk11:alpine-jre

# cd /opt/app
WORKDIR /opt/app

# cp target/spring-boot-web.jar /opt/app/app.jar
COPY springboot.war springboot.war

# java -jar /opt/app/app.jar
ENTRYPOINT ["java","-jar","springboot.war"]