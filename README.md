# rethinkdb-backup-tools-build

This project builds binaries from Python-based RethinkDB backup tools.

This is helpful as long as these packages are not contained in the original RethinkDB docker image, producing a huge docker image containing Python (see [rethinkdb-dockerfiles#57](https://github.com/rethinkdb/rethinkdb-dockerfiles/issues/57)).

Binaries include:

- rethinkdb-dump
- rethinkdb-restore

## Usage

```dockerfile
FROM ghcr.io/metal-stack/rethinkdb-backup-tools-build:2.4.0 as rethinkdb-backup-tools

FROM rethinkdb/rethinkdb:2.4.0
COPY --from rethinkdb-backup-tools /rethinkdb-dump /rethinkdb-restore /rethinkdb/
```
