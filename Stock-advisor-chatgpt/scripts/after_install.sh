#!/bin/bash
echo "After installation script"

# Set permissions
chmod +x /home/ec2-user/app/stock-advisor-0.0.1-SNAPSHOT.jar

# Create service file
cat > /etc/systemd/system/stock-advisor.service << 'EOF'
[Unit]
Description=Stock Advisor Application
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/app
ExecStart=/usr/bin/java -jar /home/ec2-user/app/stock-advisor-0.0.1-SNAPSHOT.jar
SuccessExitStatus=143
TimeoutStopSec=10
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
systemctl daemon-reload