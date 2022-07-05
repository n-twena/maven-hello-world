FROM maven:3.5.4-jdk-8-alpine AS builder
WORKDIR /home
COPY my-app/src /home
COPY my-app/pom.xml /home
RUN mvn versions:set -DnewVersion=1.0.1-SNAPSHOT
RUN mvn -B compile
RUN mvn -B package

FROM ubuntu:latest
WORKDIR /home
COPY --from=builder /home/target/my-app-1.0.1-SNAPSHOT.jar my-app-1.0.1-SNAPSHOT.jar
CMD java -jar my-app-1.0.1-SNAPSHOT.jar
