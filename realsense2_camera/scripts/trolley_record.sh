# @Author: Claus Smitt
# @Date:   2020-08-04 15:37:24
# @Last Modified by:   Claus Smitt
# @Last Modified time: 2020-08-04 16:47:04
#!/bin/bash

usage="$(basename "$0") [-h] [-p -s] -- Run trolley logger

where:
    -h  help
    -p  save folder path
    -s  folder suffix

Launches realsense2_camera trolley_record.launch to record all specified cameras

Saves odometry and raw realsense camera feeds in:
  [save folder path]/[run timestamp]_[folder suffix]/
  "

prefix=""
sufix=""

while getopts ':h:p:s:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    p) prefix=$OPTARG
       ;;
    s) sufix=$OPTARG
  esac
done
shift $((OPTIND - 1))

log_path=$prefix/$(date +%d%m%Y%H%M%S)_$sufix

mkdir -p $log_path

roslaunch realsense2_camera trolley_record.launch log_path:=$log_path
