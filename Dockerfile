FROM bellsoft/liberica-runtime-container:jdk-21-stream-musl AS builder

COPY . /build
WORKDIR /build

RUN ./mvnw -q -Dmaven.test.skip=true package

FROM bellsoft/liberica-runtime-container:jre-21-musl

WORKDIR /home/app
EXPOSE 8080
COPY --from=builder /build/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
