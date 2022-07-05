FROM maven:3.5.4-jdk-8-alpine AS builder
WORKDIR /home
COPY . /home
RUN mvn -B compile
RUN mvn -B package

FROM openjdk:8-jdk-alpine
WORKDIR /home
ARG fullname
COPY --from=builder /home/target/${fullname}.jar ${fullname}.jar
CMD java -jar ${fullname}.jar
