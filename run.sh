#!/bin/bash

################################################################################
# modifiable
RUNNABLE_PATH=/home/zhouwei/zhouwei/workspace/hadoop_home/Hadoop_0200_FileSystemAPI_Read/bin/fsread.jar
JOB_CLASS_FULL_NAME=org.myorg.FileSystemCat
INPUT_DIR_PATH=/home/zhouwei/zhouwei/workspace/hadoop_home/Hadoop_0200_FileSystemAPI_Read/input
OUTPUT_DIR_PATH=/home/zhouwei/zhouwei/workspace/hadoop_home/Hadoop_0200_FileSystemAPI_Read/output

################################################################################
# inner variables
TIMESTAMP=$(date +%Y%m%d%H%M%S_%N)
HDFS_INPUT_DIR_PATH=/tmp/input/$JOB_CLASS_FULL_NAME/$TIMESTAMP
HDFS_OUTPUT_DIR_PATH=/tmp/output/$JOB_CLASS_FULL_NAME/$TIMESTAMP
ERROR_CODE=1

################################################################################
# check
if [ $APACHE_HADOOP_VERSION = "" ]; then
	echo environment variable APACHE_HADOOP_VERSION not found
	exit $ERROR_CODE
fi
if [ $APACHE_HADOOP_HOME = "" ]; then
	echo environment variable APACHE_HADOOP_HOME not found
	exit $ERROR_CODE
fi
if [ ! -d $APACHE_HADOOP_HOME ]; then
	echo $APACHE_HADOOP_HOME does not exist or is not a directory
	exit $ERROR_CODE
fi
if [ ! -f $RUNNABLE_PATH ]; then
	exit $ERROR_CODE does not exist or is not a file
fi
if [ ! -d $INPUT_DIR_PATH ]; then
	echo $INPUT_DIR_PATH does not exist or is not a directory
	exit $ERROR_CODE
fi

################################################################################
hadoop dfs -mkdir $HDFS_INPUT_DIR_PATH
hadoop dfs -put $INPUT_DIR_PATH/* $HDFS_INPUT_DIR_PATH
hadoop jar $RUNNABLE_PATH $JOB_CLASS_FULL_NAME $HDFS_INPUT_DIR_PATH $HDFS_OUTPUT_DIR_PATH
rm -rf $OUTPUT_DIR_PATH/$TIMESTAMP
mkdir -p $OUTPUT_DIR_PATH/$TIMESTAMP
hadoop dfs -get $HDFS_OUTPUT_DIR_PATH/* $OUTPUT_DIR_PATH/$TIMESTAMP

exit 0

