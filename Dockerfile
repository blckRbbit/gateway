#Build stage
FROM gradle:latest AS BUILD
WORKDIR /usr/app/
COPY . .
RUN gradle build -x test --info

# Package stage
FROM openjdk:17-jdk-slim-buster
ENV JAR_NAME=gateway-0.0.1.jar
ENV APP_HOME=/usr/app
WORKDIR $APP_HOME
COPY --from=BUILD $APP_HOME .
EXPOSE 5555
ENTRYPOINT exec java -jar $APP_HOME/build/libs/$JAR_NAME

