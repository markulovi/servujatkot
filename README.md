# Laniservut

## Prerequisites

- Docker (with compose)
- unzip
- tar
- curl
- sed

## Installation

```
cp .env.example .env
```

Fill in the values. **THIS IS IMPORTANT**.

Latest metamod download url can be found from https://www.metamodsource.net/downloads.php?branch=dev

Latest cssharp download url can be found from https://github.com/roflmuffin/CounterStrikeSharp/releases (the one with runtime)

Latest matchzy download url can be found from https://github.com/shobhit-pathak/MatchZy/releases/ (the one without cssharp)

```
export $(grep -v '^#' .env | xargs)
```

```
export UID=$(id -u)
export GID=$(id -g)
```

```
mkdir -p cs2/steam
mkdir mumble
```

```
docker network create -d bridge caddy
docker compose up -d
```

**NOTE**: Downloading and installing CS2 server takes a lot of time. Check the logs to see if the installation is finished before proceeding.

```
docker container logs cs2-server
```

## CS2 setup

```
cp admins.example.json cs2/admins.json
```

Fill in the admins.json file with steam ids.

Run the setup script

```
./cs2.sh
```

## CS2 rcon

docker run -it --rm outdead/rcon ./rcon -a cs2.poggers.fi:27015 -p servujatkot "<komento>"

## TeamSpeak

Check teamspeak container logs for ServerAdmin privilege key

## Pro Pilkki 2

http://propilkki.net/index.php/pro-pilkki-2/verkkopelien-komennot

## Admin panels

Pilkki admin should be accessible at `https://pilkki.<your hostname>`

Get5 admin should be accessible at `https://g5.<your hostname>`

**NOTE**: DNS needs to be configured for these urls to work. Point your hostname to the host ip. You can also use the ip to access admin panels.
