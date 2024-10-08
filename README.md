# adsb.p2sh.co feed client

- These scripts aid in setting up your current ADS-B receiver to feed [adsb.p2sh.co](https://adsb.p2sh.co/).
- This will not disrupt any existing feed clients already present.
- When setting up new feeders, a decoder such as [readsb](https://github.com/wiedehopf/adsb-scripts/wiki/Automatic-installation-for-readsb) must be installed separately.

## 1: Find antenna coordinates and elevation

<https://www.freemaptools.com/elevation-finder.htm>

## 2: Install the feed client

```
curl -L -o /tmp/feed.sh https://raw.githubusercontent.com/p2sh-co/adsb-feed/main/install.sh
sudo bash /tmp/feed.sh
```

## 3: Use netstat to check that your feed is working
The feed IP for adsb.p2sh.co is 198.54.134.195

```
netstat -t -n | grep -E '30004|31090'
```
Expected Output:
```
tcp        0    182 localhost:43530     198.54.134.195:31090      ESTABLISHED
tcp        0    410 localhost:47332     198.54.134.195:30004      ESTABLISHED
```

## 4: Optional: Install [local interface](https://github.com/wiedehopf/tar1090) for your data

The interface will be available at http://192.168.X.XX/p2sh
Replace the IP address with the address of your Raspberry Pi.

Install / Update:
```
sudo bash /usr/local/share/p2sh/git/install-or-update-interface.sh
```
Remove:
```
sudo bash /usr/local/share/tar1090/uninstall.sh p2sh
```

### Update the feed client without reconfiguring

```
curl -L -o /tmp/update.sh https://raw.githubusercontent.com/p2sh-co/adsb-feed/main/update.sh
sudo bash /tmp/update.sh
```

### If you encounter issues, please do a reboot and then supply these logs on Discord (last 20 lines for each is sufficient):

```
sudo journalctl -u p2sh-feed --no-pager
sudo journalctl -u p2sh-mlat --no-pager
```

### Display the configuration

```
cat /etc/default/p2sh
```

### Changing the configuration

This is the same as the initial installation.
If the client is up to date it should not take as long as the original installation,
otherwise this will also update the client which will take a moment.

```
curl -L -o /tmp/feed.sh https://raw.githubusercontent.com/p2sh-co/adsb-feed/main/install.sh
sudo bash /tmp/feed.sh
```

### Disable / Enable adsb.p2sh.co MLAT-results in your main decoder interface (readsb / dump1090-fa)

This is enabled by default. You probably don't need to change that.

- Disable:

```
sudo sed --follow-symlinks -i -e 's/RESULTS=.*/RESULTS=""/' /etc/default/p2sh
sudo systemctl restart p2sh-mlat
```
- Enable:

```
sudo sed --follow-symlinks -i -e 's/RESULTS=.*/RESULTS="--results beast,connect,127.0.0.1:30104"/' /etc/default/p2sh
sudo systemctl restart p2sh-mlat
```

### Restart the feed client

```
sudo systemctl restart p2sh-feed
sudo systemctl restart p2sh-mlat
```

### Show status

```
sudo systemctl status p2sh-feed
sudo systemctl status p2sh-mlat
```

### Removal / disabling the services

```
sudo bash /usr/local/share/p2sh/uninstall.sh
```

If the above doesn't work, you can just disable the services and the scripts won't run anymore:

```
sudo systemctl disable --now p2sh-feed
sudo systemctl disable --now p2sh-mlat
```
