---
version: "3.3"
services:
  changedetection:
    image: lscr.io/linuxserver/changedetection.io:latest
    container_name: changed
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Pacific/Auckland
      - BASE_URL=https://yoursubdomainname.com
      - WEBDRIVER_URL=http://192.168.10.15:4444 #your LAN IP
    volumes:
      - ./config:/config
    ports:
      - 5000:5000
    networks:
      - traefikproxy
    restart: unless-stopped

  standalone-chrome:
    container_name: selenium_changed
    ports:
      - "4444:4444"
      # - 7900
    shm_size: '1gb'
    image: seleniarm/standalone-chromium:latest
    networks:
      - traefikproxy
    restart: unless-stopped

networks:
  traefikproxy:
    external: true
