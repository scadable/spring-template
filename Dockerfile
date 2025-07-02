# ── BUILD STAGE ──────────────────────────────────────────────────────────
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /workspace

COPY gradlew ./gradlew
COPY gradle  ./gradle
COPY build.gradle settings.gradle ./

RUN ./gradlew --no-daemon -Pskip.tests=true dependencies

COPY src ./src
RUN ./gradlew --no-daemon clean bootJar -x test

# ── RUNTIME STAGE ────────────────────────────────────────────────────────
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Debian-style system user creation
RUN groupadd --system spring \
 && useradd  --system --gid spring --no-create-home spring

USER spring

COPY --from=build /workspace/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
