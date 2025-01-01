FROM alpine

# Install necessary utilities temporarily
RUN apk add --no-cache util-linux wget unzip && \
    wget -qO- https://api.github.com/repos/nezhahq/agent/releases/latest | \
    grep browser_download_url | grep linux_amd64.zip | cut -d '"' -f 4 | \
    xargs wget -q -O nezha-agent_linux_amd64.zip && \
    unzip nezha-agent_linux_amd64.zip && \
    mv nezha-agent /nezha-agent && \
    rm -rf nezha-agent_linux_amd64.zip && \
    apk del wget unzip

# Add entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define entrypoint
ENTRYPOINT ["/entrypoint.sh"]
