# Excellometer - Wearable computer in Ubport

App to analyse accelerometer and gyroscope in Ubports OS (for smartphone).

Input :
- Accelerometer (<=> fixed mechanical spring : measurment movement)
- Gyroscope (<=> oscillated mecanical spring with angles : measurement deviation caused by Coriolis)


Methods :
- Times Series (fondementals)
- EWM (smooth)
- Fourier (component)
- Clustering 
- KNN
- Markov Chain
- LSTM
- CNN

Output :
Inertia measurement to behaviour


###### Attribution required : Fabien Furfaro (CC 4.0 BY NC ND SA)

Tutorial in :
	- https://www.peterspython.com/fr/blog/developpement-d-applications-ubuntu-touch-avec-python-avec-pyotherside
	- https://forums.ubports.com/topic/5525/python-examples (pavelprosto94)
	- https://api-docs.ubports.com/sdk/apps/qml/QtSensors/Qt%20Sensors%20C++%20Overview.html
	- https://open-store.io/ (if opensource code, exemple : https://github.com/balcy/SensorsStatus)

#### Part Clickable

Installation (with docker possibilities - virtual env - DevOps) :
```bash
sudo apt install docker.io adb git python3 python3-pip python3-setuptools python3-venv
pip3 install clickable-ut # don't install "clickable, it's different ! uninstall otherwise"
echo PATH=$PATH:~/.local/bin>>~/.bashrc 
# if virtual env (alternative) :
python3 -m venv .venv --system-site-packages
source ./.venv/bin/activate
```

Create 1st Apps
```bash
# docker (choose python & define app)
clickable create

# if you doing sudo (tips)
sudo chown -R username foldername
```

Be careful, the directory position is absolute in the CMakeCache.txt

**Show** in desktop (installing dependancy docker) :
```bash
cd appname
sudo clickable desktop --no-nvidia
```

Need lbgl, glx (qt&qtmake) :

```bash
sudo apt-get install libglX #hit double **Tab** output to see X
sudo apt-get install -y qt5-qmake
sudo apt install qtcreator
```

For nvidia : install nvidia-container in docker
```bash
su # sudo passwd root (necessite caractere different !)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list > /etc/apt/sources.list.d/nvidia-docker.list
apt -y install nvidia-container-toolkit
systemctl restart docker
docker run --gpus all nvidia/cuda:10.1-base nvidia-smi
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

Basic docker command :
```bash

```

```bash

```
