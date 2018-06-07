# docker-webkitgtk
builds latest webkitgtk version which can then be installed on amd64 debian stretch system

## Usage

to copy the compiled webkitgtk+ and optional surf browser tar do the following:

```

docker pull marvambass/webkitgtk
docker create --name webkitgtk marvambass/webkitgtk

docker cp webkitgtk:/wk.tar wk.tar

docker rm -f webkitgtk

# to extract and install it

tar xvf wk.tar
cd webkit*/
sudo ./install
```

### installing the optional surf browser

```
cd webkit*/
cd surf
sudo make install
```
