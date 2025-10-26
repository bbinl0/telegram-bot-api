# Telegram Bot API Local Server - Railway Deployment

এটি একটি সম্পূর্ণ Telegram Bot API সার্ভার যা Railway-তে ডিপ্লয় করার জন্য তৈরি।

## বৈশিষ্ট্য

- ✅ **বড় ফাইল আপলোড**: 2000MB পর্যন্ত ফাইল আপলোড করতে পারবেন
- ✅ **আনলিমিটেড ডাউনলোড**: কোনো সাইজ লিমিট নেই ডাউনলোডের জন্য
- ✅ **লোকাল ফাইল অ্যাক্সেস**: সরাসরি ফাইল পাথ ব্যবহার করতে পারবেন
- ✅ **দ্রুত পারফরম্যান্স**: নিজের সার্ভার হওয়ায় দ্রুত

## Railway-তে ডিপ্লয় করার ধাপ

### ধাপ ১: GitHub Repository তৈরি করুন

1. GitHub-এ একটা নতুন repository তৈরি করুন (যেকোনো নাম দিতে পারেন, যেমন: `telegram-bot-api-server`)
2. এই ফোল্ডারের সব ফাইল সেই repository তে push করুন:

```bash
cd telegram-bot-api-server
git init
git add .
git commit -m "Initial commit: Telegram Bot API server"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/telegram-bot-api-server.git
git push -u origin main
```

### ধাপ ২: Railway-তে ডিপ্লয় করুন

1. **Railway-তে যান**: https://railway.app
2. **Sign up** করুন GitHub দিয়ে (ফ্রি)
3. **New Project** ক্লিক করুন
4. **Deploy from GitHub repo** সিলেক্ট করুন
5. আপনার `telegram-bot-api-server` repository সিলেক্ট করুন

### ধাপ ৩: Environment Variables সেট করুন

Railway dashboard-এ:

1. **Variables** ট্যাবে যান
2. নিচের দুটি variable যোগ করুন:
   - `TELEGRAM_API_ID` = `27815887`
   - `TELEGRAM_API_HASH` = `dbb31988b20945abd1ee1311f543b19f`
3. **Deploy** করুন

### ধাপ ৪: Public URL পান

1. Railway আটোমেটিক্যালি একটা public URL তৈরি করবে
2. **Settings** → **Networking** → **Generate Domain** ক্লিক করুন
3. URL কপি করুন (যেমন: `telegram-bot-api-production-abc123.up.railway.app`)

## আপনার বটকে এই সার্ভারের সাথে কানেক্ট করুন

আপনার বট কোডে (`main.py`):

```python
from telebot import apihelper

# আপনার Railway URL দিয়ে পরিবর্তন করুন
BOT_API_BASE = "https://telegram-bot-api-production-abc123.up.railway.app"

apihelper.API_URL = BOT_API_BASE + "/bot{0}/{1}"
apihelper.FILE_URL = BOT_API_BASE + "/file/bot{0}/{1}"
apihelper.ENABLE_MIDDLEWARE = True
```

## লোকাল টেস্ট (ঐচ্ছিক)

লোকাল কম্পিউটারে টেস্ট করতে:

```bash
docker build -t telegram-bot-api .
docker run -p 8081:8081 \
  -e TELEGRAM_API_ID=27815887 \
  -e TELEGRAM_API_HASH=dbb31988b20945abd1ee1311f543b19f \
  telegram-bot-api
```

টেস্ট করুন:
```bash
curl http://localhost:8081/bot<YOUR_BOT_TOKEN>/getMe
```

## সমস্যা সমাধান

### সার্ভার চালু হচ্ছে না?

Railway logs দেখুন:
1. Dashboard → **Deployments** → **View Logs**

### বট কানেক্ট হচ্ছে না?

1. নিশ্চিত করুন Railway সার্ভার রানিং আছে
2. Public URL সঠিক আছে কিনা চেক করুন
3. Environment variables সঠিকভাবে সেট করা আছে কিনা দেখুন

### ফাইল আপলোড হচ্ছে না?

1. নিশ্চিত করুন `--local` ফ্ল্যাগ সেট করা আছে (Dockerfile-এ আছে)
2. ফাইল সাইজ 2000MB এর নিচে আছে কিনা চেক করুন

## API Endpoints

আপনার সার্ভার এই endpoints support করবে:

- **Bot API**: `https://your-railway-url.railway.app/bot<TOKEN>/METHOD`
- **File Download**: `https://your-railway-url.railway.app/file/bot<TOKEN>/<FILE_PATH>`

## লিমিটেশন

- ফ্রি টায়ার: Railway-তে মাসে 500 ঘণ্টা ফ্রি
- পেইড প্ল্যান: $5 credit ফ্রি পাবেন শুরুতে

## সাহায্য

কোনো সমস্যা হলে:
1. Railway logs চেক করুন
2. GitHub Issues-এ জানান
3. Telegram Bot API ডকুমেন্টেশন: https://core.telegram.org/bots/api

---

**তৈরি করেছেন**: Replit Agent  
**সর্বশেষ আপডেট**: October 26, 2025
