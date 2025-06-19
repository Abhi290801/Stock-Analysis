#!/bin/bash

# Create deployment directory
mkdir -p deploy

# Copy all necessary files from Stock-advisor-chatgpt to deploy
cp -r Stock-advisor-chatgpt/* deploy/
cp -r Stock-advisor-chatgpt/.* deploy/ 2>/dev/null || :

# Create Railway configuration files in the deploy directory
cat > deploy/railway.toml << EOF
[build]
builder = "NIXPACKS"
buildCommand = "mvn clean package -DskipTests"

[deploy]
startCommand = "java -jar target/stock-advisor-0.0.1-SNAPSHOT.jar"
restartPolicyType = "ON_FAILURE"
EOF

# Create Procfile
echo "web: java -jar target/stock-advisor-0.0.1-SNAPSHOT.jar" > deploy/Procfile

# Create nixpacks.toml to explicitly set the builder
cat > deploy/nixpacks.toml << EOF
[phases.setup]
nixPkgs = ["maven", "jdk11"]

[phases.build]
cmds = ["mvn clean package -DskipTests"]

[start]
cmd = "java -jar target/stock-advisor-0.0.1-SNAPSHOT.jar"
EOF

echo "Deployment files prepared in the 'deploy' directory."
echo "To deploy to Railway:"
echo "1. cd deploy"
echo "2. git init"
echo "3. git add ."
echo "4. git commit -m 'Initial commit'"
echo "5. railway link (if using CLI)"
echo "6. railway up (if using CLI)"
echo "Or deploy via the Railway dashboard by connecting to this Git repository"