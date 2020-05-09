# Terraria Server Docker Containers

A personal dockerfile for bringing up Terraria servers in docker
containers.

-----------------------------------------------

## Usage

### Quickstart

```
docker create -it \
-v <config path>:/config \
-v <worlds path>:/worlds \
-p <port>:7777 \
-e world=<world file> \
--name="terraria" \
terrariaserver:latest

docker start terraria
```

### Setup

If you haven't built the docker image yet:

```
git clone https://github.com/joshbarrass/docker-terrariaserver
cd docker-terrariaserver
docker build --tag terrariaserver:latest .
```

You can now use the image interactively to create the default config
files and to create a new world.

```
docker run -it \
-v <config path>:/config \
-v <worlds path>:/worlds \
terrariaserver:latest
```

Once you have created a world, you can build a more permanent docker
container, which will allow you to bring the server up in the
background, e.g. as a service.

```
docker create -it \
-v <config path>:/config \
-v <worlds path>:/worlds \
-p <port>:7777 \
-e world=<world file> \
--name="terraria" \
terrariaserver:latest
```

To run the server, use `docker start terraria`. You can also attach to
the server using `docker attach terraria`. Keep in mind that using the
detach keybinding (by default, `C-p C-q`) will interrupt STDIN inside
the container. **This will cause the server to crash without saving!**
To avoid this, you can either attach in a new terminal and close the
terminal when finished, or you can manually kill the `docker attach`
process. These will cause `docker attach` to be killed, detaching it
from the container without interrupting STDIN.
