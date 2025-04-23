# sight-health-check

10분마다 사이트가 살아있는지 확인 후, 문제가 있다면 운영진 디스코드로 메시지를 보냅니다.

## Run

```sh
chmod +x ./health_check.sh
./health_check.sh
```

## Environments

|         Name          | Description                                 |
| :-------------------: | :------------------------------------------ |
| `DISCORD_WEBHOOK_URL` | 알림 메시지를 보낼 디스코드 채널의 웹훅 URL |

## License

[MIT License](LICENSE)
