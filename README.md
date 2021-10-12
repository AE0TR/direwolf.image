# DAAC -  Direwolf As A Container

## Usage
After building the image with
```bash
docker build -t direwolf .
```
and editing the example `direwolf.conf.example` 

run a container with

```bash
docker run --device=/dev/bus/usb/001/004 --privileged --name=direwolf -v $(pwd)/direwolf.conf:/data/direwolf.conf --restart=unless-stopped -d direwolf
```
