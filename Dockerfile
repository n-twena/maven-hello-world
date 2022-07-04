FROM maven:3.5.4-jdk-8-alpine AS build
WORKDIR /home
COPY my-app/src /home
COPY my-app/pom.xml /home
RUN mvn -B compile
RUN mvn -B package

FROM ubuntu:latest
WORKDIR /home
COPY --from=builder src/target/*.jar .
