#!/bin/bash
echo "Before installation script"

# Create application directory if it doesn't exist
mkdir -p /home/ec2-user/app

# Install Java if not already installed
if ! command -v java &> /dev/null; then
    echo "Installing Java..."
    amazon-linux-extras install java-openjdk11 -y
fi