@echo off
setlocal
set "APP_HOME=%~dp0"
set "WRAPPER_JAR=%APP_HOME%gradle\wrapper\gradle-wrapper.jar"
if not exist "%WRAPPER_JAR%" (
    powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-8.9-wrapper.jar' -OutFile '%WRAPPER_JAR%'"
    if errorlevel 1 exit /b 1
)
for /f %%H in ('powershell -NoProfile -Command "(Get-FileHash -Algorithm SHA256 '%WRAPPER_JAR%').Hash.ToLower()"') do set "ACTUAL=%%H"
if /I not "%ACTUAL%"=="498495120a03b9a6ab5d155f5de3c8f0d986a449153702fb80fc80e134484f17" (
    echo O Gradle Wrapper nao passou na verificacao de integridade.
    del "%WRAPPER_JAR%"
    exit /b 1
)
java -classpath "%WRAPPER_JAR%" org.gradle.wrapper.GradleWrapperMain %*
endlocal
