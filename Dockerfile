FROM maven:3.5.3-jdk-10

WORKDIR /usr/src/java-code
RUN git clone https://github.com/spring-projects/spring-petclinic
WORKDIR /usr/src/java-code/spring-petclinic
RUN mvn -q -B package -DskipTests

RUN mkdir /usr/src/java-app
RUN cp -v /usr/src/java-code/spring-petclinic/target/*.jar /usr/src/java-app/app.jar

# Build the application running image
FROM openjdk:10

RUN export
WORKDIR /app
COPY --from=0 /usr/src/java-app/*.jar ./

CMD java -Dserver.port=${SERVER_PORT:-}\
          -Dserver.context-path=/petclinic/\
          -Dspring.messages.basename=messages/messages\
          -Dlogging.level.org.springframework=${LOG_LEVEL:-INFO}\
          -Dsecurity.ignored=${SECURITY_IGNORED:-/**}\
          -Dbasic.authentication.enabled=${AUTHENTICATION_ENABLED:-false}\
          -Dserver.address=${SERVER_ADDRESS:-0.0.0.0}\
          -jar /app/app.jar
