#!/bin/bash

SITE_URL="https://khlug.org"
DISCORD_WEBHOOK_URL=$DISCORD_WEBHOOK_URL
OUTPUT_FILE="output.txt"
GITHUB_ACTION_URL=$GITHUB_ACTION_URL

check_site() {
    response=$(curl -s -o "$OUTPUT_FILE" -w "%{http_code}" -I -m 30 $SITE_URL)
    curl_exit_code=$?
    current_time=$(TZ="Asia/Seoul" date "+%Y-%m-%d %H:%M:%S")
    
    # 200 응답이 아니면 오류로 간주
    if [ "$response" != "200" ]; then
        if [ "$response" == "000" ]; then
            message="🔴 **경고:** 사이트 접속 에러가 발생하고 있어요! (exit code: $curl_exit_code) ($current_time)"
        else
            message="🔴 **경고:** 사이트가 정상 응답을 못 하고 있어요! (status_code=$response) ($current_time)"
        fi

        message="$message\n관련 액션 바로가기: $GITHUB_ACTION_URL"
        
        # Discord에 알림 전송
        curl -H "Content-Type: application/json" -d "{\"content\": \"$message\"}" $DISCORD_WEBHOOK_URL

        if [[ -s "$OUTPUT_FILE" ]]; then
            echo "$message"
            cat "$OUTPUT_FILE"
        else
            echo "$message"
            echo "(출력 결과 없음)"
        fi

        exit 1
    else
        echo "✅ $SITE_URL 사이트 정상 작동 중 (응답 코드: $response) - $current_time"
    fi
}

check_site