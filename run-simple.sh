#!/bin/bash

cd Stock-advisor-chatgpt

# Download Maven if not present
if [ ! -d "maven" ]; then
    echo "Downloading Maven..."
    mkdir -p maven
    cd maven
    wget https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz
    tar -xzf apache-maven-3.8.8-bin.tar.gz
    cd ..
fi

# Set Maven path
MAVEN_HOME="$(pwd)/maven/apache-maven-3.8.8"
MAVEN_BIN="$MAVEN_HOME/bin/mvn"

# Make Maven executable
chmod +x $MAVEN_BIN

# Clean and run
echo "Building and running the application..."
$MAVEN_BIN clean spring-boot:run