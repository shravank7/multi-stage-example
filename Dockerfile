FROM maven:3.8.6-openjdk-8 AS builder

RUN mkdir -p /app/source

COPY . /app/source

WORKDIR /app/source

RUN mvn clean package


# Stage 2 - Runtime
FROM eclipse-temurin:8-jre

COPY --from=builder /app/source/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]
