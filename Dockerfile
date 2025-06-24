FROM rethinkdb:2.4.4-bookworm-slim AS rethinkdb-python-client-builder
WORKDIR /work
RUN apt update && apt install -y python3-pip
RUN pip3 install pyinstaller==6.14.1 rethinkdb --break-system-packages
COPY build/rethinkdb-dump.spec rethinkdb-dump.spec
COPY build/rethinkdb-restore.spec rethinkdb-restore.spec
RUN pyinstaller rethinkdb-dump.spec \
    && pyinstaller rethinkdb-restore.spec

FROM scratch
COPY --from=rethinkdb-python-client-builder /work/dist/rethinkdb-dump /work/dist/rethinkdb-restore /
