# Telegram Local Bot API server (official image)
FROM ghcr.io/tdlib/telegram-bot-api:latest

# ── আপনার হার্ডকোড করা ক্রেডেনশিয়াল ──
ENV TELEGRAM_API_ID=27815887
ENV TELEGRAM_API_HASH=dbb31988b20945abd1ee1311f543b19f

# ক্যাশ/ডেটা ডিরেক্টরি (ইমেজে ডিফল্টও এইটা)
ENV TELEGRAM_DIR=/var/lib/telegram-bot-api

# Railway সাধারণত $PORT দেয়; না পেলে 8081 ধরবে
EXPOSE 8081

# সবকিছু অটো-স্টার্ট: Local Bot API সার্ভার 0.0.0.0:$PORT এ bind হবে
# --dir দিয়ে ডেটা/ক্যাশ লোকেশন সেট; -v 3 = একটু বেশি লগ
CMD ["/bin/sh","-c", "\
  telegram-bot-api --local \
    --api-id=${TELEGRAM_API_ID} \
    --api-hash=${TELEGRAM_API_HASH} \
    --http-ip-address=0.0.0.0 \
    --http-port=${PORT:-8081} \
    --dir=${TELEGRAM_DIR} \
    -v 3 \
"]
