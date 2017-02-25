#!/bin/bash

function isDirExist(){
	if [ -d $1 ]; then
		echo "$1 dir exist"
	else
		echo "$1 dir not exist"
	fi
}
function isFileExist(){
	if [ -f $1 ]; then
		echo "$1 file exist"
	else
		echo "$1 file not exist"
	fi
}
