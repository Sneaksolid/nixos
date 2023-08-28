#!/usr/bin/env bash

function encrypt() {
	echo "enc ${1} => ${2}"
	sops -e $1 > $2
}

function decrypt() {
	echo "dec ${1} => ${2}"
	sops -d $1 > $2
}

function traverse_and_exec() {
  for file in `ls $2`
  do
	source=${2}/${file}
	target=${3}/${file}
	if [ ! -d $source ]; then
	  mkdir -p $(dirname $target)
	  $1 $source $target
	else
	  traverse_and_exec $1 $source $target
	fi
  done
}

function main() {
	traverse_and_exec $1 $2 $3
}

if [ "$1" == "encrypt" ]; then
	source=./secrets_plain
	target=./secrets
else
	source=./secrets
	target=./secrets_plain
fi

main $1 $source $target
