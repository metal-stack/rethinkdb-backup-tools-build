FROM rethinkdb:2.4.1 as rethinkdb-python-client-builder
WORKDIR /work
RUN apt update && apt install -y python3-pip
RUN pip3 install pyinstaller==4.3.0 rethinkdb
COPY build/rethinkdb-dump.spec rethinkdb-dump.spec
COPY build/rethinkdb-restore.spec rethinkdb-restore.spec
RUN pyinstaller rethinkdb-dump.spec \
    && pyinstaller rethinkdb-restore.spec

FROM scratch
COPY --from=rethinkdb-python-client-builder /work/dist/rethinkdb-dump /work/dist/rethinkdb-restore /
