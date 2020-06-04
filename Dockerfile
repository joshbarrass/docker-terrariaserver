FROM ubuntu:18.04

WORKDIR /tmp
RUN  apt-get update \
  && apt-get install -y wget unzip \
  && rm -rf /var/lib/apt/lists/*

RUN groupadd -r terraria && useradd -rm -g terraria terraria

# create and chown the volumes and dirs before switching user
RUN mkdir -p /config && chown -R terraria:terraria /config
RUN mkdir -p /worlds && chown -R terraria:terraria /worlds
RUN mkdir -p /tmp/server && chown -R terraria:terraria /tmp/server
RUN mkdir -p /usr/server && chown -R terraria:terraria /usr/server

USER terraria

ENV VERSION=1353
RUN cd server \
  && wget https://terraria.org/server/terraria-server-$VERSION.zip -O server.zip \
  && unzip server.zip "$VERSION/Linux/*" "$VERSION/Windows/serverconfig.txt" \
  && cp $VERSION/Windows/serverconfig.txt $VERSION/Linux/defaultconfig.txt \
  && rm -rf "$VERSION/Windows" \
  && mv "$VERSION"/Linux/* /usr/server \
  && cd /tmp \
  && rm -rf server

WORKDIR /usr/server
COPY --chown=terraria:terraria run-server.sh run-server.sh
COPY --chown=terraria:terraria MIT MIT
RUN wget https://github.com/joshbarrass/TerrariaServerWrapper/releases/download/v1.0.2/TerrariaServerWrapper-x64 -O TerrariaServerWrapper
RUN chmod +x TerrariaServer* run-server.sh

VOLUME /config
VOLUME /worlds

RUN mkdir -p ~/.local/share/Terraria \
  && ln -s /worlds ~/.local/share/Terraria/Worlds

EXPOSE 7777

CMD ["./run-server.sh"]
