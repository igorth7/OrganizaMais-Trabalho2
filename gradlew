#!/bin/sh
APP_HOME=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
WRAPPER_JAR="$APP_HOME/gradle/wrapper/gradle-wrapper.jar"
if [ ! -f "$WRAPPER_JAR" ]; then
    if command -v curl >/dev/null 2>&1; then
        curl -fL --retry 2 --connect-timeout 20 "https://services.gradle.org/distributions/gradle-8.9-wrapper.jar" -o "$WRAPPER_JAR" || exit 1
    elif command -v wget >/dev/null 2>&1; then
        wget -O "$WRAPPER_JAR" "https://services.gradle.org/distributions/gradle-8.9-wrapper.jar" || exit 1
    else
        echo "Instale curl ou wget para obter o Gradle Wrapper." >&2
        exit 1
    fi
fi
EXPECTED="498495120a03b9a6ab5d155f5de3c8f0d986a449153702fb80fc80e134484f17"
if command -v shasum >/dev/null 2>&1; then
    ACTUAL=$(shasum -a 256 "$WRAPPER_JAR" | awk '{print $1}')
elif command -v sha256sum >/dev/null 2>&1; then
    ACTUAL=$(sha256sum "$WRAPPER_JAR" | awk '{print $1}')
else
    echo "É necessário sha256sum ou shasum para verificar o Gradle Wrapper." >&2
    exit 1
fi
if [ "$EXPECTED" != "$ACTUAL" ]; then
    echo "O Gradle Wrapper não passou na verificação de integridade." >&2
    rm -f "$WRAPPER_JAR"
    exit 1
fi
exec java -classpath "$WRAPPER_JAR" org.gradle.wrapper.GradleWrapperMain "$@"
