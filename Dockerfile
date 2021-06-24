FROM openjdk:8-jre-alpine
ARG artifactid
ARG version
ENV artifact ${artifactid}-${version}.jar
WORKDIR /app
COPY --from=build /app/target/${artifact} /app
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar ${artifact}"]
