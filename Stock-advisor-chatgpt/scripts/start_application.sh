#!/bin/bash
echo "Starting application"

# Start the service
systemctl start stock-advisor
systemctl enable stock-advisor