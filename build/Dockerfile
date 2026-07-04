# Stage 1: Build the WAR using Ant
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

COPY . .

RUN apt-get update && \
    apt-get install -y ant && \
    ant clean dist

# Stage 2: Run Tomcat
FROM tomcat:11.0-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /app/dist/Question.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]