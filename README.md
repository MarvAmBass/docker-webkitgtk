# docker-webkitgtk
builds latest webkitgtk version which can then be installed on amd64 debian stretch system

## Usage

to copy the compiled webkitgtk+ `tar.gz` do the following:

```

docker pull marvambass/webkitgtk
docker create --name webkitgtk marvambass/webkitgtk

docker cp webkitgtk:/wk.tar.gz wk.tar.gz

docker rm -f webkitgtk

# to extract and install it

tar xvf wk.tar.gz
cd webkit*/
sudo ./install
```
