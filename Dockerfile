FROM maven:3.5.4-jdk-8-alpine AS builder
WORKDIR /home
COPY my-app/src /home
COPY my-app/pom.xml /home
RUN mvn -B release:prepare release:perform
RUN mvn -B compile
RUN mvn -B package

FROM ubuntu:latest
WORKDIR /home
COPY --from=builder /home/target/*.jar my-app.jar 
CMD java -jar my-app-SNAPSHOT.jar
