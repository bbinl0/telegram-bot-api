# Telegram Bot API server (Docker Hub image to avoid GHCR 403)
FROM aiogram/telegram-bot-api:latest

# ── আপনার হার্ডকোড করা ক্রেডেনশিয়াল ──
# ⚠️ নিরাপত্তার জন্য পাবলিক রিপোতে দেবেন না; প্রাইভেট রাখুন।
ENV TELEGRAM_API_ID=27815887
ENV TELEGRAM_API_HASH=dbb31988b20945abd1ee1311f543b19f

# ক্যাশ/ডেটা লোকেশন (ইমেজে ডিফল্ট এই পাথই)
ENV TELEGRAM_DIR=/var/lib/telegram-bot-api

# Railway সাধারণত $PORT দেয়; না পেলে 8081 ব্যবহার হবে
EXPOSE 8081

# সরাসরি বাইনারি রান করি যাতে $PORT নিশ্চিতভাবে ধরা হয়
# --local = Local Bot API মোড (বড় ফাইল আপ/ডাউনলোড সুবিধা)
# --http-ip-address=0.0.0.0 = Railway-তে bind
CMD ["/bin/sh","-c", "\
  telegram-bot-api --local \
    --api-id=${TELEGRAM_API_ID} \
    --api-hash=${TELEGRAM_API_HASH} \
    --http-ip-address=0.0.0.0 \
    --http-port=${PORT:-8081} \
    --dir=${TELEGRAM_DIR} \
    -v 3 \
"]
