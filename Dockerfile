FROM maven:3.5.4-jdk-8-alpine AS builder
WORKDIR /home
COPY my-app/src /home
COPY my-app/pom.xml /home
RUN mvn -B compile
RUN mvn -B package

FROM ubuntu:latest
WORKDIR /home
COPY --from=builder target/my-app-1.0.0-SNAPSHOT.jar /home
CMD exec java -jar my-app-1.0.0-SNAPSHOT.jar
