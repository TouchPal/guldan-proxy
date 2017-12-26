BINARY=guldan-proxy

VERSION=`cat VERSION`
BUILD_TIME=`date +%FT%T%z`
GIT_HASH=`git rev-parse HEAD`

LDFLAGS="-X main.AppVersion=${VERSION} -X main.AppBuildTime=${BUILD_TIME} -X main.AppGitHash=${GIT_HASH}"

all:
	go build -ldflags ${LDFLAGS} -o ${BINARY} apps/guldan-proxy/main.go

clean:
	rm -rf ${BINARY}
