# Laniservut

## Prerequisites

- x86 Unix environment (Linux, WSL or Mac)
- Docker Compose

## Installation and usage

Try to make sure your user has uid=1000 and gid=1000.
This is mostly required for CS2, as the container user has those IDs and needs read access to the bind mount.
Check with `id`.

CS2 is assumed to be ran with only one server at a time. The scripts will stop possible other servers before starting.

### Mumble and Pro Pilkki 2

```
docker compose up -d
```

### CS2 Regular

Start server, plugins and configuration are automatic:

```
cd cs2
./start-cs2.sh

# Stop server after match
./stop.sh
```

### CS2 Hunni (Max players 32)

```
cd cs2
./start-hunni.sh

# Stop server after match
./stop.sh
```

### CS2 MatchZy commands

Everyone is an admin. Commands below can be used to set up maps and matches.

Remember to set team names with `.team1 Team1Name` and `.team2 Team2Name`

https://shobhit-pathak.github.io/MatchZy/commands/

### CS2 RCON

RCON is available in CS2 chat:

```
.rcon mp_friendlyfire 1
```

Also possible with Docker:

```
# Substitute hostname, RCON password and optionally port with correct values for environment
docker run -it --rm outdead/rcon ./rcon -a $SERVER_HOSTNAME:27015 -p $CS2_RCONPW "mp_friendlyfire 1"
```

## Mumble

Login as SuperUser with password from `.env`.

Configuration can then be done from the Mumble client.

By default, SuperUser cannot talk. If a user needs admin rights and wants to be able to talk, someone needs to connect as SuperUser and add that user to the `admin` group:

1. Right click server root -> Edit
2. Go to Groups tab
3. Choose `admin` group
4. Pick user or write username into field next to Add button under Members
5. Click Add

## Pro Pilkki 2

https://propilkki.net/wp/verkkopelien-komennot/

### Starting the map

1. Connect to the server
2. Obtain admin privileges by entering `/admin <adminpassword>` in chat
3. Set map by picking the correct line from `propilkki2/autohost.ini` and pasting to chat
4. Type `/wait 300` to start the map in 300 seconds. (A high value is preferred for a break between maps)
5. After the map has finished, the wait time specified above will pass and the next map will start. Set the next map with instructions from step 3 before that happens.

### Configuration

Configuration is applied at Docker image build time.

Edit `propilkki/pp2host.conf` and `propilkki/autohost.ini` and force rebuild

```
docker compose up -d --build propilkki2
```

By default only `$ORGA` and `$ADMIN` variables are passed to the build process.

## Troubleshooting

CS2 logs:

```
cd cs2
docker compose logs -f
```


### CSTV

Might have delay. If so, send `.rcon tv_delay 0` to chat as MatchZy admin and hope for the best.

### CS2 error: Client is out of date

Redownload server files:

```
cd cs2

# Either
./repair-cs2.sh

# or
./repair-hunni.sh
```

### CS2 error: Client delta ticks out of order

Happens with CSTV. No idea why. Spectate normally.
