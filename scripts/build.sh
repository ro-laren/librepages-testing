#!/bin/bash
# CI Build script
# Copyright © 2021 yourname
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

readonly CONTENT_DIR=content
readonly DIST_DIR=dist
readonly DONATIONS="/donate.gmi"

help() {
	cat << EOF
build.sh: CI build script
USAGE:
    build.sh <options>
OPTIONS:
  b   build     build website
  c   clean     clean dependencies and build artifacts
  h   help      print this help menu
EOF
}

check_arg(){
	if [ -z $1 ]
	then
		help
		exit 1
	fi
}

match_arg() {
	if [ $1 == $2 ] || [ $1 == $3 ]
	then
		return 0
	else
		return 1
	fi
}

clean() {
	rm -rf $DIST_DIR || true
}

last_mod() {
	git --no-pager log -1 --pretty="format:Last modified: %ci%n" content/index.gmi
}

prep_dist() {
	for i in $(find $CONTENT_DIR -type d)
	do
		mkdir -p $DIST_DIR/$i
	done
}

nav() {
	echo >> $NEW_FILE
	echo "--------" >> $NEW_FILE
	echo >> $NEW_FILE

	last_mod $file >> $NEW_FILE
	echo "=> / Home" >> $1
	echo "=> $DONATIONS Donate" >> $1
}

build() {
	prep_dist
	for file in $(find $CONTENT_DIR -type f)
	do 
		NEW_FILE=$DIST_DIR/$file
		cat $file > $NEW_FILE
		nav $NEW_FILE
	done
}

check_arg $1

if match_arg $1 'b' 'build'
then
	build
elif match_arg $1 'c' 'clean'
then
	clean
elif match_arg $1 'h' 'help'
then
	help
else
	echo "Error: $1 is not an option"
	help
	exit 1
fi

exit 0
