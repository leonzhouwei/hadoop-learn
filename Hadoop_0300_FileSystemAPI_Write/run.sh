#!/bin/bash

################################################################################
# modifiable
RUNNABLE_PATH=/home/zhouwei/zhouwei/workspace/hadoop_home/Hadoop_0300_FileSystemAPI_Write/bin/fswrite.jar
JOB_CLASS_FULL_NAME=org.myorg.FileCopyWithProgress
HDFS_INPUT_DIR_PATH=/tmp/$JOB_CLASS_FULL_NAME/input/hello.txt
HDFS_OUTPUT_DIR_PATH=/tmp/$JOB_CLASS_FULL_NAME/output/hello.txt

################################################################################
# inner variables
#TIMESTAMP=$(date +%Y%m%d%H%M%S_%N)
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
hadoop jar $RUNNABLE_PATH $JOB_CLASS_FULL_NAME $HDFS_INPUT_DIR_PATH $HDFS_OUTPUT_DIR_PATH

exit 0
