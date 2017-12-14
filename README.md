# Experimental Gluster block Container

# Prerequisite

Ensure target_core_user kernel module is loaded.

# Build
```bash
# docker build -t gluster-block .
```

# Run

```bash
# docker run -ti --privileged -v /lib/modules:/lib/modules gluster-block
```