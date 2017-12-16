#!/bin/bash

# Copyright 2015 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DIR="/vol"

function start()
{
    /usr/sbin/glusterd -p /run/glusterd.pid
    rpcbind
    /usr/bin/tcmu-runner &
    /usr/sbin/gluster-blockd & 
    gluster volume create test_vol `hostname -i`:${DIR} force
    gluster volume start test_vol
    /usr/sbin/gluster-block create test_vol/vol1 ha 1 `hostname -i` 1GiB
}

function stop()
{
    gluster --mode=script volume stop test_vol force
    kill $(cat /run/glusterd.pid)
    pkill -9 gluster-blockd
    pkill -9 tcmu-runner 
    pkill -9 rpcbind
    exit 0
}

if [ ! -d ${DIR} ]
then
    echo "No gluster volume is bound to ${DIR}, exiting..."
fi


trap stop TERM

start "$@"

while true; do
    sleep 5
done
