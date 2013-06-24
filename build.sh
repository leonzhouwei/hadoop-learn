#!/bin/bash

################################################################################
HADOOP_VERSION=1.0.4
HADOOP_HOME=/home/zhouwei/zhouwei/software/hadoop/hadoop-$HADOOP_VERSION
PROJECT_HOME=/home/zhouwei/zhouwei/workspace/hadoop_home/WordCount
SRC=src
BIN=bin
SOURCES_LIST=sources.list
RUNNABLE=wordcount.jar

################################################################################
SRC_PATH=$PROJECT_HOME/$SRC
BIN_PATH=$PROJECT_HOME/$BIN
RUNNABLE_PATH=$BIN_PATH/$RUNNABLE
SOURCES_LIST_PATH=$PROJECT_HOME/$SOURCES_LIST

################################################################################
if [ -d $BIN_PATH ]; then
    rm -rf $BIN_PATH/*
else 
    mkdir -p $BIN_PATH
fi

rm -f $SOURCES_LIST_PATH
find $SRC_PATH -name *.java > $SOURCES_LIST_PATH

javac -verbose -classpath $HADOOP_HOME/hadoop-core-$HADOOP_VERSION.jar -d $BIN_PATH @$SOURCES_LIST_PATH 
jar -cvf $RUNNABLE_PATH -C $BIN_PATH/ .

exit 0