#!/bin/bash

################################################################################
# modifiable variables
PROJECT_HOME=/home/zhouwei/zhouwei/workspace/hadoop_home/Hadoop_0200_FileSystemAPI_Read
SRC=src
BIN=bin
SOURCES_LIST=sources.list
RUNNABLE=fsread.jar

################################################################################
# inner variables
SRC_DIR_PATH=$PROJECT_HOME/$SRC
BIN_DIR_PATH=$PROJECT_HOME/$BIN
SOURCES_LIST_PATH=$PROJECT_HOME/$SOURCES_LIST
RUNNABLE_PATH=$BIN_DIR_PATH/$RUNNABLE
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
if [ ! -d $PROJECT_HOME ]; then
	echo $PROJECT_HOME does not exist or is not a directory
	exit $ERROR_CODE
fi

################################################################################
# build
if [ -d $BIN_DIR_PATH ]; then
    rm -rf $BIN_DIR_PATH/*
else 
    mkdir -p $BIN_DIR_PATH
fi

rm -f $SOURCES_LIST_PATH
find $SRC_DIR_PATH -name *.java > $SOURCES_LIST_PATH

javac -verbose -classpath $APACHE_HADOOP_HOME/hadoop-core-$APACHE_HADOOP_VERSION.jar -d $BIN_DIR_PATH @$SOURCES_LIST_PATH 
jar -cvf $RUNNABLE_PATH -C $BIN_DIR_PATH/ .

exit 0

