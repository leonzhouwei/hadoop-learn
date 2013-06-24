#!/bin/bash

################################################################################
HADOOP_VERSION=1.0.4
HADOOP_HOME=/home/zhouwei/zhouwei/software/hadoop/hadoop-$HADOOP_VERSION
HADOOP_CMD=$HADOOP_HOME/bin/hadoop
RUNNABLE_PATH=/home/zhouwei/zhouwei/workspace/hadoop_home/WordCount/bin/wordcount.jar
JOB_CLASS_FULL_NAME=org.myorg.WordCount
INPUT_DIR_PATH=/home/zhouwei/zhouwei/workspace/hadoop_home/WordCount/input
OUTPUT_DIR_PATH=/home/zhouwei/zhouwei/workspace/hadoop_home/WordCount/output

################################################################################
TIMESTAMP=$(date +%Y%m%d%H%M%S_%N)
HDFS_INPUT_DIR_PATH=/tmp/input/$JOB_CLASS_FULL_NAME/$TIMESTAMP
HDFS_OUTPUT_DIR_PATH=/tmp/output/$JOB_CLASS_FULL_NAME/$TIMESTAMP

################################################################################
$HADOOP_CMD dfs -mkdir $HDFS_INPUT_DIR_PATH
$HADOOP_CMD dfs -put $INPUT_DIR_PATH/* $HDFS_INPUT_DIR_PATH
$HADOOP_CMD jar $RUNNABLE_PATH $JOB_CLASS_FULL_NAME $HDFS_INPUT_DIR_PATH $HDFS_OUTPUT_DIR_PATH
rm -rf $OUTPUT_DIR_PATH/$TIMESTAMP
mkdir $OUTPUT_DIR_PATH/$TIMESTAMP
$HADOOP_CMD dfs -get $HDFS_OUTPUT_DIR_PATH/* $OUTPUT_DIR_PATH/$TIMESTAMP

exit 0