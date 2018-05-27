# fastd-BATMAN

Installations-Script for fastd and B.A.T.M.A.N.

Installiert batman-adv, batctl und fastd mit dem Script: batman-fastd-install.sh

Aufruf

 sudo ./batman-fastd-install.sh
 
batman und batctl wird aus den Quellen compliert. Daher müssen diese Programme auch per HAnd aktualisiert werden.

Aktualisieren

 sudo ./batman-fastd-update.sh

## Start des Dienstes

B.A.T.M.A.N. wird gestartet mit 

 modprobe batman-adv
 
Um batman-adv mit jedem Neustart automatisch zu laden muss folgende Zeilöe in /etc/modules eingetragen werden. (Wird bei der Installtion erledigt.)

 batman-adv
 
Fastd wird gestartet mit 

 service fastd start

Um fastd mit jedem Neustart automatisch zu starten, muss der folgende Befehl ausgeführt werden:

 systemctl enable fastd

