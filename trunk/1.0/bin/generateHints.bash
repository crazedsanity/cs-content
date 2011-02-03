#!/bin/bash
grep -i "^class " * -R --exclude=*.svn* --exclude=*.tmp| grep -e ".php" -e ".inc" | cut --delimiter=" " --fields 1,2 | sed "s/class //" | sed "s/:/\|/"
grep -i "^abstract class " * -R --exclude=*.svn* --exclude=*.tmp| grep -e ".php" -e ".inc" | cut --delimiter=" " --fields 1,3 | sed "s/abstract //" | sed "s/:/\|/"
