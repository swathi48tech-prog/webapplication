@echo off
REM Build script for Training Portal Web Application (Windows)
REM This script compiles Java classes and creates a WAR file

echo ========================================
echo Building Training Portal Application
echo ========================================

SET PROJECT_NAME=training-portal
SET WAR_FILE=%PROJECT_NAME%.war

REM Check if TOMCAT_HOME is set
if "%TOMCAT_HOME%"=="" (
    echo WARNING: TOMCAT_HOME environment variable is not set
    set /p TOMCAT_HOME="Enter Tomcat installation path (e.g., C:\tomcat): "
)

REM Check if ORACLE_JDBC is set
if "%ORACLE_JDBC%"=="" (
    echo WARNING: ORACLE_JDBC path is not set
    set /p ORACLE_JDBC="Enter path to Oracle JDBC JAR file (e.g., C:\ojdbc8.jar): "
)

REM Servlet API path
SET SERVLET_API=%TOMCAT_HOME%\lib\servlet-api.jar

REM Check if required files exist
if not exist "%SERVLET_API%" (
    echo ERROR: servlet-api.jar not found at %SERVLET_API%
    echo Please check your TOMCAT_HOME path
    pause
    exit /b 1
)

if not exist "%ORACLE_JDBC%" (
    echo ERROR: Oracle JDBC JAR not found at %ORACLE_JDBC%
    pause
    exit /b 1
)

echo Using Tomcat: %TOMCAT_HOME%
echo Using Oracle JDBC: %ORACLE_JDBC%

REM Create necessary directories
echo.
echo Step 1: Creating directories...
if not exist WEB-INF\classes\com\trainingportal mkdir WEB-INF\classes\com\trainingportal
if not exist META-INF mkdir META-INF
if not exist css mkdir css
if not exist js mkdir js
if not exist database mkdir database

REM Compile Java source files
echo.
echo Step 2: Compiling Java source files...

REM Check if Java compiler is available
where javac >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: javac not found. Please install JDK
    pause
    exit /b 1
)

REM Compile all Java files
javac -cp "%SERVLET_API%;%ORACLE_JDBC%" -d WEB-INF\classes WEB-INF\classes\com\trainingportal\*.java

if %ERRORLEVEL% EQU 0 (
    echo √ Compilation successful
) else (
    echo × Compilation failed
    pause
    exit /b 1
)

REM Remove .java files from classes directory
echo.
echo Step 3: Cleaning up source files from classes directory...
del /S /Q WEB-INF\classes\*.java >nul 2>&1

REM Create WAR file
echo.
echo Step 4: Creating WAR file...

REM Remove old WAR file if exists
if exist %WAR_FILE% (
    del /F /Q %WAR_FILE%
    echo Removed old WAR file
)

REM Create WAR using jar command
jar -cvf %WAR_FILE% META-INF WEB-INF css js *.html

if %ERRORLEVEL% EQU 0 (
    echo √ WAR file created successfully: %WAR_FILE%
) else (
    echo × Failed to create WAR file
    pause
    exit /b 1
)

REM Display WAR file info
echo.
echo ========================================
echo Build Summary
echo ========================================
echo WAR File: %WAR_FILE%
for %%A in (%WAR_FILE%) do echo Size: %%~zA bytes
echo.

REM Display first few entries
echo WAR Contents (first 20 entries):
jar -tf %WAR_FILE% | more

REM Deployment instructions
echo.
echo ========================================
echo Deployment Instructions
echo ========================================
echo 1. Copy %WAR_FILE% to Tomcat webapps:
echo    copy %WAR_FILE% %TOMCAT_HOME%\webapps\
echo.
echo 2. Start Tomcat:
echo    %TOMCAT_HOME%\bin\startup.bat
echo.
echo 3. Access application at:
echo    http://localhost:8080/%PROJECT_NAME%/
echo.
echo ========================================
echo Build completed successfully!
echo ========================================

pause
