# fastd-BATMAN
Installation Script for fastd and B.A.T.M.A.N.

Installation mit dem script install-batman

## Start des Dienstes

B.A.T.M.A.N. wird gestartet mit 

 modprobe batman-adv
 
Fastd wird gestartet mit 

 service fastd start

Um fastd mit jedem Neustart automatisch zu starten, muss der folgende Befehl ausgeführt werden:

 systemctl enable fastd

