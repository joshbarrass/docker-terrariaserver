FROM ubuntu:18.04

WORKDIR /tmp
RUN  apt-get update \
  && apt-get install -y wget unzip \
  && rm -rf /var/lib/apt/lists/*

ENV VERSION=1353

RUN mkdir -p server \
  && cd server \
  && wget https://terraria.org/server/terraria-server-$VERSION.zip -O server.zip \
  && unzip server.zip "$VERSION/Linux/*" "$VERSION/Windows/serverconfig.txt" \
  && cp $VERSION/Windows/serverconfig.txt $VERSION/Linux/defaultconfig.txt \
  && rm -rf "$VERSION/Windows" \
  && mv "$VERSION/Linux" /usr/server \
  && cd /tmp \
  && rm -rf server

WORKDIR /usr/server
COPY run-server.sh run-server.sh
COPY MIT MIT
RUN wget https://github.com/joshbarrass/TerrariaServerWrapper/releases/download/v1.0.1/TerrariaServerWrapper-x64 -O TerrariaServerWrapper
RUN chmod +x TerrariaServer* run-server.sh

VOLUME /config
VOLUME /worlds

RUN mkdir -p ~/.local/share/Terraria \
  && ln -s /worlds ~/.local/share/Terraria/Worlds

EXPOSE 7777

CMD ["./run-server.sh"]
