#!/usr/bin/env bash
eval `ssh-agent -s`
pub_keys=~/.ssh/*.pub
keys=
for key in $pub_keys
do
  keys="$keys ${key//.pub/}"
done

ssh-add $keys
