#!/bin/sh
echo "Pulling swift_runtime"
docker pull cscix65g/swift-runtime:arm64-latest
if [ ! "$(docker ps --all -q -f name=swift_runtime)" ]; then
    echo "Launching swift_runtime"
    if [ "$(docker volume ls | grep swift_runtime_usr_bin)" ]; then
	    echo "    removing old swift_runtime_usr_bin"		
		docker volume rm swift_runtime_usr_bin >> /dev/null
    fi
    echo "    creating swift_runtime_usr_bin"		
    docker volume create swift_runtime_usr_bin
    if [ "$(docker volume ls | grep swift_runtime_usr_lib)" ]; then
	    echo "    removing old swift_runtime_usr_lib"		
  	    docker volume rm swift_runtime_usr_lib >> /dev/null
    fi
    echo "    creating swift_runtime_usr_lib"		
    docker volume create swift_runtime_usr_lib
    if [ "$(docker volume ls | grep swift_runtime_lib)" ]; then
	    echo "    removing old swift_runtime_lib"		
        docker volume rm swift_runtime_lib >> /dev/null
    fi
    echo "    creating swift_runtime_lib"		
    docker volume create swift_runtime_lib
    
    echo "Starting up swift_runtime.  ignore architecture warnings."		
    docker run --detach --name swift_runtime -v swift_runtime_usr_lib:/usr/lib -v swift_runtime_usr_bin:/usr/bin -v swift_runtime_lib:/lib cscix65g/swift-runtime:arm64-latest
    docker logs swift_runtime
fi

echo "\n\nRunning helloworld:"		
docker run --rm --name helloworld -v /lib:/lib -v /usr/lib:/usr/lib -v /usr/bin:/usr/bin -v swift_runtime_usr_lib:/swift_runtime/usr/lib -e LD_LIBRARY_PATH=/lib/aarch64-linux-gnu:/swift_runtime/usr/lib/aarch64-linux-gnu:/usr/bin:/swift_runtime/usr/lib/swift/linux helloworld:arm64-latest
