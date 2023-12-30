FROM ubuntu:22.04

# install utility tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo wget iproute2 iputils-ping git nano python3 python3-pip \
    make gcc build-essential zlib1g-dev net-tools xrdp 

# install tool
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nmap openvpn hping3 dirb 

# xfce
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    xfce4 \
    xfce4-clipman-plugin \
    xfce4-cpugraph-plugin \
    xfce4-netload-plugin \
    xfce4-screenshooter \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-xkb-plugin 

RUN DEBIAN_FRONTEND=noninteractive apt remove -y light-locker xscreensaver gnome-* && \
    apt autoremove -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists

# xrdp conf
RUN mkdir /var/run/dbus && \
    cp /etc/X11/xrdp/xorg.conf /etc/X11 && \
    sed -i "s/console/anybody/g" /etc/X11/Xwrapper.config && \
    sed -i "s/xrdp\/xorg/xorg/g" /etc/xrdp/sesman.ini && \
    echo "xfce4-session" >> /etc/skel/.Xsession

# # install dirsearch
RUN git clone https://github.com/maurosoria/dirsearch.git /opt/dirsearch
RUN pip3 install -r /opt/dirsearch/requirements.txt
WORKDIR  /opt/dirsearch
RUN python3 /opt/dirsearch/setup.py install

# # make sslscan
RUN git clone https://github.com/rbsec/sslscan.git /opt/sslscan
WORKDIR  /opt/sslscan
RUN cd /opt/sslscan && make static

# # download code 
RUN git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists
RUN git clone https://github.com/sullo/nikto.git /opt/nikto

# set root password
RUN echo "root:root" | chpasswd
RUN mkdir /tmp/mnt_host
WORKDIR  /root
CMD service xrdp start; bash