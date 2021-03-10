swift build --destination /Library/Developer/Destinations/amd64-5.3.3-RELEASE.json
docker build --file ./Dockerfile-amd64 --tag helloworld:amd64-latest .
