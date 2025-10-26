# Mixed/Advanced: Local Bot API + Railway-friendly port + explicit run
FROM aiogram/telegram-bot-api:latest

# --- Your hardcoded creds (as you asked) ---
ENV TELEGRAM_API_ID=27815887
ENV TELEGRAM_API_HASH=dbb31988b20945abd1ee1311f543b19f

# Working dirs (image defaults too)
ENV TELEGRAM_DIR=/var/lib/telegram-bot-api
ENV TELEGRAM_TEMP_DIR=/tmp/telegram-bot-api

# Verbose logs a bit, can change to 2/1 later
ENV TELEGRAM_VERBOSITY=3

# Expose default (Railway will still inject $PORT)
EXPOSE 8081

# Run the server directly (bypass entrypoint) so we control all flags.
# Binds to 0.0.0.0, uses $PORT if provided, else 8081.
ENTRYPOINT ["/bin/sh","-c","exec telegram-bot-api \
  --local \
  --api-id=${TELEGRAM_API_ID} \
  --api-hash=${TELEGRAM_API_HASH} \
  --http-ip-address=0.0.0.0 \
  --http-port=${PORT:-8081} \
  --dir=${TELEGRAM_DIR} \
  --temp-dir=${TELEGRAM_TEMP_DIR} \
  --username=telegram-bot-api \
  --groupname=telegram-bot-api \
  -v ${TELEGRAM_VERBOSITY}"]
