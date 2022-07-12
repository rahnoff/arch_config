setup L2TP IPsec VPN in archlinux using NetworkManager
====

install packages first:

```bash
yay -S xl2tpd strongswan networkmanager-l2tp
```

> ref: https://wiki.archlinux.org/index.php/Openswan_L2TP/IPsec_VPN_client_setup
> yay: https://github.com/Jguer/yay

then reboot or `systemctl restart NetworkManager`

### using commandline only

```bash
nmcli c add con-name CON_NAME type vpn vpn-type l2tp vpn.data 'gateway=GATEWAY_HOST, ipsec-enabled=yes, ipsec-psk=PRE_SHARED_KEY, password-flags=2, user=USERNAME'
nmcli c edit CON_NAME # interactive mode, type help for manual
nmcli c up CON_NAME
nmcli c down CON_NAME
nmcli c delete CON_NAME
```

* password-flags=0 => Save password in plain text
* password-flags=1 => Save encrypted password
* password-flags=2 => Don't save password, ask when needed
  * when using this, `nmcli c up CON_NAME --ask` is needed

### via GNOME/KDE Plasma GUI

#### GNOME

![add vpn in gnome](https://i.imgur.com/TqQOwyl.png)

![options of l2tp ipsec](https://i.imgur.com/CmMoGNL.png)

#### KDE PLASMA

![add_vpn_in_kde](https://i.imgur.com/UqFSnrh.png)

![options_of_kde_l2tp_ipsec](https://i.imgur.com/YHywDja.png)

* `Gateway` is the ip of the vpn server
* `User name` is the given user
* Password can be left blank to enter when connecting
* click `IPsec Settings...` button
  * Check `Enable IPsec tunnel to L2TP host`
  * paste PSK to `Pre-shared key`
  * *IMPORTANT* Uncheck `Enable IPsec tunnel to L2TP host` before click `OK` button, I think this is a bug
* click `Add` button and enable
