#!/bin/bash

# Build script for Training Portal Web Application
# This script compiles Java classes and creates a WAR file

echo "========================================"
echo "Building Training Portal Application"
echo "========================================"

# Configuration
PROJECT_NAME="training-portal"
WAR_FILE="${PROJECT_NAME}.war"

# Check if TOMCAT_HOME is set
if [ -z "$TOMCAT_HOME" ]; then
    echo "WARNING: TOMCAT_HOME environment variable is not set"
    echo "Please set it or provide the path manually"
    read -p "Enter Tomcat installation path (e.g., /opt/tomcat): " TOMCAT_PATH
    TOMCAT_HOME=$TOMCAT_PATH
fi

# Check if ORACLE_JDBC is set
if [ -z "$ORACLE_JDBC" ]; then
    echo "WARNING: ORACLE_JDBC path is not set"
    read -p "Enter path to Oracle JDBC JAR file (e.g., /path/to/ojdbc8.jar): " JDBC_PATH
    ORACLE_JDBC=$JDBC_PATH
fi

# Servlet API path
SERVLET_API="$TOMCAT_HOME/lib/servlet-api.jar"

# Check if required files exist
if [ ! -f "$SERVLET_API" ]; then
    echo "ERROR: servlet-api.jar not found at $SERVLET_API"
    echo "Please check your TOMCAT_HOME path"
    exit 1
fi

if [ ! -f "$ORACLE_JDBC" ]; then
    echo "ERROR: Oracle JDBC JAR not found at $ORACLE_JDBC"
    exit 1
fi

echo "Using Tomcat: $TOMCAT_HOME"
echo "Using Oracle JDBC: $ORACLE_JDBC"

# Create necessary directories
echo ""
echo "Step 1: Creating directories..."
mkdir -p WEB-INF/classes/com/trainingportal
mkdir -p META-INF
mkdir -p css
mkdir -p js
mkdir -p database

# Compile Java source files
echo ""
echo "Step 2: Compiling Java source files..."

# Check if Java compiler is available
if ! command -v javac &> /dev/null; then
    echo "ERROR: javac not found. Please install JDK"
    exit 1
fi

# Find all Java source files
JAVA_FILES=$(find WEB-INF/classes/com/trainingportal -name "*.java")

if [ -z "$JAVA_FILES" ]; then
    echo "ERROR: No Java source files found"
    exit 1
fi

# Compile
javac -cp "$SERVLET_API:$ORACLE_JDBC" \
      -d WEB-INF/classes \
      $JAVA_FILES

if [ $? -eq 0 ]; then
    echo "✓ Compilation successful"
else
    echo "✗ Compilation failed"
    exit 1
fi

# Remove .java files from classes directory (keep only .class files)
echo ""
echo "Step 3: Cleaning up source files from classes directory..."
find WEB-INF/classes -name "*.java" -delete

# Create WAR file
echo ""
echo "Step 4: Creating WAR file..."

# Remove old WAR file if exists
if [ -f "$WAR_FILE" ]; then
    rm -f "$WAR_FILE"
    echo "Removed old WAR file"
fi

# Create WAR
jar -cvf "$WAR_FILE" \
    META-INF/ \
    WEB-INF/ \
    css/ \
    js/ \
    *.html

if [ $? -eq 0 ]; then
    echo "✓ WAR file created successfully: $WAR_FILE"
else
    echo "✗ Failed to create WAR file"
    exit 1
fi

# Display WAR file info
echo ""
echo "========================================"
echo "Build Summary"
echo "========================================"
echo "WAR File: $WAR_FILE"
echo "Size: $(ls -lh $WAR_FILE | awk '{print $5}')"
echo ""

# Check contents
echo "WAR Contents:"
jar -tf "$WAR_FILE" | head -20
echo "..."
echo ""

# Deployment instructions
echo "========================================"
echo "Deployment Instructions"
echo "========================================"
echo "1. Copy $WAR_FILE to Tomcat webapps:"
echo "   cp $WAR_FILE $TOMCAT_HOME/webapps/"
echo ""
echo "2. Start Tomcat:"
echo "   $TOMCAT_HOME/bin/startup.sh"
echo ""
echo "3. Access application at:"
echo "   http://localhost:8080/$PROJECT_NAME/"
echo ""
echo "========================================"
echo "Build completed successfully!"
echo "========================================"
