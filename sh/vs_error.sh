#!/bin/bash

tmppath=$(find ~/.vscode-server/bin/ -name "server.sh")
sed -i '12d' $tmppath
cat ~/vs_error >> $tmppath
