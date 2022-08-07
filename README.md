# Excellometer - Wearable computer in Ubport

App to analyse accelerometer and gyroscope in Ubports OS (for smartphone).

*Input :*

- Accelerometer (<=> fixed mechanical spring : measurment movement)
- Gyroscope (<=> oscillated mecanical spring with angles : measurement deviation caused by Coriolis)


*Methods :*

- Times Series (fondementals)
- EWM (smooth)
- Fourier (component)
- Clustering 
- KNN
- Markov Chain
- LSTM
- CNN

*Output :*

Inertia measurement to behaviour

**Inspiration :**

- https://github.com/JanderHungrige/PumpSensor (LSTM of physics sensor)
- https://github.com/mabelc/EDA_medium (EDA of accelerometer)
- https://towardsdatascience.com/feature-engineering-on-time-series-data-transforming-signal-data-of-a-smartphone-accelerometer-for-72cbe34b8a60
- https://github.com/kaiolae/wcci2018_prediction_tutorial (complete course)

###### Attribution required : Fabien Furfaro (CC 4.0 BY NC ND SA)

Tutorial in :

- https://www.peterspython.com/fr/blog/developpement-d-applications-ubuntu-touch-avec-python-avec-pyotherside
- https://forums.ubports.com/topic/5525/python-examples (pavelprosto94)
- https://api-docs.ubports.com/sdk/apps/qml/QtSensors/Qt%20Sensors%20C++%20Overview.html
- https://open-store.io/ (if opensource code, exemple : https://github.com/balcy/SensorsStatus, https://gitlab.com/ubports/development/apps/clock-app)
- https://mimecar.gitbooks.io/ubuntu-touch-programming-course/content/en/chapter-05-s01.html (weatherrecorder)
    - https://github.com/mimecar/ubuntu-touch-programming-course-src
- https://docs.innerzaurus.com/en/latest/tools/clickable.html

#### Part Clickable

Prerequiere :

```bash
#sudo apt-get install libglX #hit double **Tab** output to see X
sudo apt-get install qt5-default # if you don't find (obsolete), use synaptic package manager to see the new name (or apt list | grep qt5)
#sudo apt install qtbase5-dev qtchooser qtbase5-dev-tools
sudo apt-get install build-essential #libgl1-mesa-dev
```

Installation (with docker possibilities - virtual env - DevOps) :
```bash
sudo apt install docker.io adb git python3 python3-pip python3-setuptools python3-venv android-tools-adb android-tools-fastboot
sudo add-apt-repository ppa:bhdouglass/clickable
sudo apt-get install clickable
    # pip3 install clickable-ut # don't install "clickable, it's different ! uninstall otherwise"
    #echo PATH=$PATH:~/.local/bin>>~/.bashrc 
# if virtual env (alternative) :
python3 -m venv .venv --system-site-packages
source ./.venv/bin/activate
```

Create 1st Apps
```bash
# docker (choose python & define app)
clickable create
# we need to setup docker
cd appname
clickable setup docker # first use
sudo systemctl restart docker  # first use (that install image for docker)
# if you doing sudo (tips)
sudo chown -R username foldername
```

Be careful, the directory position is absolute in the CMakeCache.txt

**Show** in desktop (installing dependancy docker) :
```bash
cd appname
sudo clickable desktop --no-nvidia # if GLX problem, use X server X.org driver ! For me, it's works (my nvidia gpu is very old..), no need "--no" after that
```

Otherwise, screencasting :

    - sudo apt install mplayer
    - adb exec-out timeout 120 mirscreencast -m /run/mir_socket --stdout --cap-interval 2 -s 384 640 | mplayer -demuxer rawvideo -rawvideo w=384:h=640:format=rgba -

    - sudo apt-get install phablet-tools # very old !

Or qml testing :

    - sudo apt intall qml
    - sudo apt -y install qml-module-* #QtQuick, QtControl, ...
    - sudo snap install ubuntu-ui-toolkit # for Xenial : deb http://fr.archive.ubuntu.com/ubuntu xenial main universe (add in sudo gedit /etc/apt/sources.list)
        - sudo apt-get install qml-module-ubuntu-components
    - qml Main.qml

Or emulation :

    - sudo apt install qemu qemu-kvm qemu-system qemu-utils kmod
    - sudo apt install libvirt-clients libvirt-daemon-system virtinst
    - sudo apt-get install qemu virt-manager virt-viewer libvirt-bin
        - reboot and activate virtualization in Bios
    - snap install utqemu --edge # based on snap qemu-virgil
    - sudo snap connect utqemu:kvm
    - utqemu start

If doesn't work, or you have nvidia without container, use VM with Xorg server :

    - qemu-img create Puppy.vdi 10G
    - qemu-system-x86_64 -boot d -cdrom Desktop/puppy.iso -m 512
    - qemu-system-x86_64 -hda puppy.vdi
        - run virt-manager (possible de tout faire en GUI)

Transfer files to virtual machine :

    - f


For nvidia : install nvidia-container in docker
```bash
#su # sudo passwd root (necessite caractere different !) # if doesn't work in normal user..
distribution=ubuntu18.04

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
#docker run --gpus all nvidia/cuda:10.1-base nvidia-smi
```

**Show** in adb device (developper mode only) :
```bash
cd appname
sudo clickable
```

Tips :
```bash
# reboot device (if bugging)
adb reboot
```

Publish in OpenStore :
```bash
cd appname
sudo clickable publish
```

#### Part Code

Project architechture code :

```bash
*- clickable.json
*- hello_world.desktop.in
*- CMakeLists.txt
*- hello_world.apparmor
*- manifest.json.in
assets/
 - logo.svg
build/
* - #this where you get the .click file
po/
 - hello_world.gmnx.pot
 - CMakeLists.txt
python-lib/
 - #shared object for target platform (.so file). there is python and pyotherside in this folder
qml/
 - Main.qml
src/
 - hello_world.py #the python logic is here
```

Adding modules (in Main.qml)
```bash

```

```bash

```

```bash

```

#### Bonus Part.

Docker is a tools to virtualize OS-level application/service, it's adapted for container compatibilities in all platforms. (inspired of linux)

Tuto in : https://github.com/ttwthomas/apprendre-docker

Basic docker command :
```bash
# lanch container
docker run container_img
# specific container
docker run hello-world
docker run -it ubuntu bash # it == interactive (for launch bash here)
# list of container
docker ps 
# delete container
docker rm container_id # or exit in docker bash
```

Create image in docker (python) :
```bash
## create requirements.txt (& app.py) file :
Flask
Redis
## create "Dockerfile" with :
FROM python:2.7-slim
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
EXPOSE 80
ENV NOM coca
CMD ["python", "app.py"]
## build
docker build -t image_name .
## launch docker (here it's app)
docker run -p 80:80 image_name
```
--> here, we don't need python of Flask+Redis installed in computer to works.

Docker Compose :
```bash

```