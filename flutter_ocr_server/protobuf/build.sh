#python3 -m pip install grpcio-tools
#pub global activate protoc_plugin
#export PATH="$PATH":"$HOME/.pub-cache/bin"
#export PATH=$PATH:/usr/lib/dart/bin
mkdir ../rpc
python3 -m grpc_tools.protoc -I . --python_out=../rpc --grpc_python_out=../rpc ./server.proto
python3 -m grpc_tools.protoc -I . --dart_out=grpc:../../lib  --plugin=protoc-gen-dart=/home/yingshaoxo/.pub-cache/bin/protoc-gen-dart ./server.proto 
