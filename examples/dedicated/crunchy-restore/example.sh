#!/bin/bash

# Copyright 2017 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# this is an example of creating a postgres database using
# the crunchy-master template from the CLI

source $CCPROOT/examples/envvars.sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PROJECT=jeff-project

#oc process --parameters -n $PROJECT crunchy-restore

oc process -n $PROJECT crunchy-restore \
	NAME=restoredb \
	PG_MASTER_PORT=5432 \
	PG_MASTER_USER=master \
	PGDATA_PATH_OVERRIDE=example \
	PG_MASTER_PASSWORD=password \
	PG_USER=testuser \
	PG_PASSWORD=password \
	PG_DATABASE=userdb \
	PG_ROOT_PASSWORD=password \
	CCP_IMAGE_TAG=rhel7-9.6-1.3.0 \
	CCP_IMAGE_PREFIX=172.30.240.45:5000/$PROJECT \
	CCP_IMAGE_NAME=crunchy-postgres \
	BACKUP_PATH=example-backups/2017-04-05-13-25-51 \
	BACKUP_PVC=backup-pvc \
	PVC_NAME=restoredb-pvc \
	PVC_SIZE=300M \
	PVC_ACCESS_MODE=ReadWriteMany \
	| oc create -f -