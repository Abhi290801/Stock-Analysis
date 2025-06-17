#!/bin/bash

# Setup project structure
mkdir -p Stock-advisor-chatgpt/src/main/java/com/example/stockadvisor/controller
mkdir -p Stock-advisor-chatgpt/src/main/java/com/example/stockadvisor/service
mkdir -p Stock-advisor-chatgpt/src/main/java/com/example/stockadvisor/model
mkdir -p Stock-advisor-chatgpt/src/main/java/com/example/stockadvisor/config
mkdir -p Stock-advisor-chatgpt/src/main/resources/templates
mkdir -p Stock-advisor-chatgpt/src/main/resources/static/css
mkdir -p Stock-advisor-chatgpt/src/main/resources/static/js
mkdir -p Stock-advisor-chatgpt/src/main/resources/static/images

# Create pom.xml
cat > Stock-advisor-chatgpt/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.0</version>
        <relativePath/>
    </parent>
    <groupId>com.example</groupId>
    <artifactId>stock-advisor</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>stock-advisor</name>
    <description>Stock Advisor App</description>
    
    <properties>
        <java.version>11</java.version>
    </properties>
    
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
        <dependency>
            <groupId>org.thymeleaf.extras</groupId>
            <artifactId>thymeleaf-extras-springsecurity5</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>2.7.0</version>
            </plugin>
        </plugins>
    </build>
</project>
EOF

echo "Project structure and pom.xml created."