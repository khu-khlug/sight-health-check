#!/bin/bash

SITE_URL="https://khlug.org"
DISCORD_WEBHOOK_URL=$DISCORD_WEBHOOK_URL

check_site() {
    response=$(curl -s -o /dev/null -w "%{http_code}" -I -m 10 $SITE_URL)
    current_time=$(date "+%Y-%m-%d %H:%M:%S")
    
    # 200 응답이 아니면 오류로 간주
    if [ "$response" != "200" ]; then
        if [ "$response" == "000" ]; then
            message="🔴 **경고:** 사이트 접속 에러가 발생하고 있어요! ($current_time)"
        else
            message="🔴 **경고:** 사이트가 정상 응답을 못 하고 있어요! (status_code=$response) ($current_time)"
        fi
        
        # Discord에 알림 전송
        curl -H "Content-Type: application/json" -d "{\"content\": \"$message\"}" $DISCORD_WEBHOOK_URL
        echo "$message"
        exit 1
    else
        echo "✅ $SITE_URL 사이트 정상 작동 중 (응답 코드: $response) - $current_time"
    fi
}

check_site