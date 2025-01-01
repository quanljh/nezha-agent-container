#!/bin/sh

CONFIG_FILE="/root/config.yml"
if [ ! -f "$CONFIG_FILE" ]; then
    # Check if CLIENT_SECRET environment variable is set
    if [ -z "$CLIENT_SECRET" ]; then
        echo "Error: CLIENT_SECRET environment variable is not set."
        exit 1
    fi

    # Check if SERVER environment variable is set
    if [ -z "$SERVER" ]; then
        echo "Error: SERVER environment variable is not set."
        exit 1
    fi

    UUID=$(uuidgen)
    cat << EOF > "$CONFIG_FILE"
client_secret: ${CLIENT_SECRET}
server: ${SERVER}
tls: ${TLS:-false}
uuid: ${UUID}
EOF
fi

exec /nezha-agent -c "$CONFIG_FILE" 2>&1