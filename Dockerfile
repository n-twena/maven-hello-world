FROM maven:3.5.4-jdk-8-alpine AS builder
WORKDIR /home
COPY my-app/src /home
COPY my-app/pom.xml /home
RUN mvn versions:set -DnewVersion=1.0.1-SNAPSHOT
RUN mvn -B compile
RUN mvn -B package

FROM openjdk:8-jdk-alpine
WORKDIR /home
ARG fullname
COPY --from=builder /home/target/${fullname}.jar ${fullname}.jar
CMD java -jar ${fullname}.jar
