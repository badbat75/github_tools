#!/bin/bash

function create_repo () {
	set -x
	curl -i -u ${USERNAME}:${TOKEN} https://api.github.com/user/repos -d "{\"name\":\"${REPONAME}\"}"
	mkdir -p ${REPONAME}
	pushd ${REPONAME}
	git init
	#git config credential.helper store
	[ ! -f README.md ] && touch README.md
	git add .
	git commit -m "first commit"
	git branch -M main
	git remote add origin https://${USERNAME}:${TOKEN}@github.com/${USERNAME}/${REPONAME}.git
	git push -u origin main
	set +x
}

if [ -z ${1} ]; then
	echo "Specify repository name"
	exit 1
fi

MYPATH=$(dirname $(realpath ${0}))
REPONAME=${1}

if [ ! -f ${MYPATH}/github_tools.conf ]; then
	echo "Configure ${MYPATH}/github_tools.conf"
	exit 1
fi

. ${MYPATH}/github_tools.conf

set -e
create_repo > ${1}.log 2>&1
set +e

echo "Repository ${REPONAME}.git created!"
