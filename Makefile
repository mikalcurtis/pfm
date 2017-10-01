#==================================================
# 
#   Version: %version: 1.1 %
#    Stored: %date_modified: Thu Oct 12 11:05:04 2000 %
#
#==================================================

#JAVACOMPILE = javac -classpath $(CLASSPATH) 
JAVACOMPILE = javac -g -deprecation 

default: all

include that.depends

all:	$(CLASSES)
	jar cmf mainClass pfm_v2.jar pfm.properties $(CLASSES)
