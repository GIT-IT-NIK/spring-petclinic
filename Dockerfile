FROM openjdk:8-jre-alpine
RUN  apk update && apk upgrade && apk add netcat-openbsd && apk add tar
RUN  mkdir -p /usr/local/pipeline-demo

ARG JAR_FILE
COPY target/${JAR_FILE} /usr/local/pipeline-demo/pipeline-demo.jar

CMD ["/bin/sh", "-c", "java -Dspring.profiles.active=${PROFILE} -jar /usr/local/pipeline-demo/pipeline-demo.jar"]
