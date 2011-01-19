#!/bin/bash
grep "^class " * -R --exclude=*.svn* --exclude=*.tmp| grep ".php" | cut --delimiter=" " --fields 1,2 | sed "s/class //" | sed "s/:/\|/"> class.hints
