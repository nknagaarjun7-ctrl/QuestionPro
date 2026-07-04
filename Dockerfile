# ---------- Build Stage ----------
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

RUN apt-get update && apt-get install -y ant

COPY . .

RUN ant clean dist

# ---------- Runtime Stage ----------
FROM tomcat:11.0

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /app/dist/Question.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]