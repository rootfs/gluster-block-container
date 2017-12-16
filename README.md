# Experimental Gluster block Container

# Prerequisite

Ensure target_core_user kernel module is loaded.

# Build
```bash
# docker build -t gluster-block .
```

# Run

```bash
# docker run -ti --privileged -v /path/to/xfs:/vol -v /lib/modules:/lib/modules gluster-block
```

# All in one

```bash
# bash run.s
```