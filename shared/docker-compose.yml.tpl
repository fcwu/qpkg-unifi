version: '2'

networks:
  unifi:
    driver: qnet
    ipam:
      driver: qnet
      driver_opts:
        iface: DEFAULT_NIC

services:
  unifi:
    restart: always
    image: jacobalberty/unifi:5.4.11
    networks:
      unifi: {}
    volumes:
      - ${PWD}/data/var/lib/unifi:/var/lib/unifi
      - ${PWD}/data/var/log/unifi:/var/log/unifi
      - ${PWD}/data/var/run/unifi:/var/run/unifi
    environment:
      - TZ=America/Chicago
