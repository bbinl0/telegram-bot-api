#!/usr/bin/env python3
"""
Telegram Bot API Server টেস্ট স্ক্রিপ্ট
এটি দিয়ে আপনার সার্ভার ঠিকমতো কাজ করছে কিনা চেক করুন
"""

import requests
import sys

def test_server(server_url, bot_token):
    """
    সার্ভার টেস্ট করে
    
    Args:
        server_url: আপনার Railway সার্ভার URL (যেমন: https://your-app.railway.app)
        bot_token: আপনার বট টোকেন
    """
    print(f"🔍 টেস্ট করছি: {server_url}")
    print(f"🤖 বট টোকেন: {bot_token[:10]}...")
    print("-" * 50)
    
    # API URL তৈরি করি
    api_url = f"{server_url}/bot{bot_token}/getMe"
    
    try:
        # সার্ভারে রিকোয়েস্ট পাঠাই
        print(f"📡 রিকোয়েস্ট পাঠাচ্ছি: {api_url}")
        response = requests.get(api_url, timeout=10)
        
        # রেসপন্স চেক করি
        if response.status_code == 200:
            data = response.json()
            if data.get("ok"):
                bot_info = data.get("result", {})
                print("\n✅ সফল! সার্ভার ঠিকমতো কাজ করছে!")
                print(f"📌 বটের নাম: {bot_info.get('first_name')}")
                print(f"📌 ইউজারনেম: @{bot_info.get('username')}")
                print(f"📌 বট ID: {bot_info.get('id')}")
                return True
            else:
                print(f"\n❌ এরর: {data}")
                return False
        else:
            print(f"\n❌ HTTP Error {response.status_code}")
            print(f"Response: {response.text}")
            return False
            
    except requests.exceptions.Timeout:
        print("\n⏱️ টাইমআউট! সার্ভার রেসপন্ড করছে না।")
        print("💡 চেক করুন: Railway সার্ভার চালু আছে কিনা")
        return False
    except requests.exceptions.ConnectionError:
        print("\n🔌 কানেকশন এরর! সার্ভারে যুক্ত হতে পারছে না।")
        print("💡 চেক করুন: URL সঠিক আছে কিনা")
        return False
    except Exception as e:
        print(f"\n❌ অপ্রত্যাশিত এরর: {e}")
        return False


if __name__ == "__main__":
    print("=" * 50)
    print("🚀 Telegram Bot API Server টেস্ট")
    print("=" * 50)
    
    # উদাহরণ ব্যবহার
    if len(sys.argv) < 3:
        print("\n📖 ব্যবহার:")
        print("  python test_server.py <SERVER_URL> <BOT_TOKEN>")
        print("\n📝 উদাহরণ:")
        print("  python test_server.py https://telegram-bot-api-production-78b2.up.railway.app 8438671402:AAFNZUF5TiFBChTfr5ugVxZSdKKir00vTOs")
        sys.exit(1)
    
    server_url = sys.argv[1].rstrip('/')
    bot_token = sys.argv[2]
    
    # টেস্ট চালাই
    success = test_server(server_url, bot_token)
    
    if success:
        print("\n" + "=" * 50)
        print("✅ সব কিছু ঠিক আছে! বট ব্যবহার করতে পারেন।")
        print("=" * 50)
        sys.exit(0)
    else:
        print("\n" + "=" * 50)
        print("❌ সমস্যা আছে! উপরের ইন্সট্রাকশন দেখুন।")
        print("=" * 50)
        sys.exit(1)
