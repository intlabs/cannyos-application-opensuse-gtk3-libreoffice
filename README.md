## CannyOS opensuse with GTK3


This repository contains the *Dockerfile* and *associated files* for setting up a container with opensuse and GTK3 for CannyOS

### Dependencies

* docker


### Installation

1. Install [Docker](https://www.docker.io/).

	For an opensuse 14.04 host the following command will get you up and running:

	`sudo apt-get -y update && sudo apt-get -y install docker.io && sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker && sudo restart docker.io`

2. You can then build the container set from the via entering:

	Manual building can be done with the following:
	`sudo docker build -t="intlabs/cannyos-application-opensuse-gtk3-libreoffice" github.com/intlabs/cannyos-application-opensuse-gtk3-libreoffice`

	Two stage building should not be required but is avaliblible via:
	`bash <(curl -s https://raw.githubusercontent.com/intlabs/cannyos-application-opensuse-gtk3-libreoffice/master/Build.sh)`

	
### Usage

* this will run and drop you into a session with privileges to run FUSE:

`docker run -i -t --rm  --privileged=true --lxc-conf="native.cgroup.devices.allow = c 10:229 rwm"  --volume "/CannyOS/build/cannyos-application-opensuse-gtk3-libreoffice":"/CannyOS/Host"  --name "cannyos-application-opensuse-gtk3-libreoffice"  --user "root"  -p 80 intlabs/cannyos-application-opensuse-gtk3-libreoffice`
