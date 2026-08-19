FROM alpine:3.19

RUN apk add --no-cache \
    curl \
    bash \
    ca-certificates \
    socat \
    tzdata \
    sqlite \
    && ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime

# نصب X-UI
RUN curl -L https://github.com/mhsanaei/3x-ui/releases/download/v2.9.4/x-ui-linux-amd64.tar.gz -o /tmp/x-ui.tar.gz \
    && tar -xzf /tmp/x-ui.tar.gz -C /usr/local/ \
    && rm /tmp/x-ui.tar.gz \
    && chmod +x /usr/local/x-ui/x-ui

RUN mkdir -p /etc/x-ui /var/log/x-ui

COPY start.sh /start.sh
RUN chmod +x /start.sh

# پورت را داینامیک می‌کنیم
EXPOSE ${PORT:-2053}

CMD ["/start.sh"]
