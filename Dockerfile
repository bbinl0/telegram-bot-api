FROM aiogram/telegram-bot-api:latest

ENV TELEGRAM_API_ID=27815887
ENV TELEGRAM_API_HASH=dbb31988b20945abd1ee1311f543b19f
ENV TELEGRAM_DIR=/var/lib/telegram-bot-api
ENV TELEGRAM_TEMP_DIR=/tmp/telegram-bot-api
ENV TELEGRAM_VERBOSITY=2

EXPOSE 8081

# ⚠️ লক্ষ্য করুন: --local flag নেই!
ENTRYPOINT ["/bin/sh","-c","exec telegram-bot-api \
  --api-id=${TELEGRAM_API_ID} \
  --api-hash=${TELEGRAM_API_HASH} \
  --http-ip-address=0.0.0.0 \
  --http-port=${PORT:-8081} \
  --dir=${TELEGRAM_DIR} \
  --temp-dir=${TELEGRAM_TEMP_DIR} \
  --username=telegram-bot-api \
  --groupname=telegram-bot-api \
  -v ${TELEGRAM_VERBOSITY}"]
