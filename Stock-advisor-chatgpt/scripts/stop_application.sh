#!/bin/bash
echo "Stopping application"

# Stop the service if it's running
if systemctl is-active --quiet stock-advisor; then
    systemctl stop stock-advisor
fi