
# Before getting started (For Virtual Macihne)

Let's just install some "MUST" packages for connect the virtual machine from our own terminal.

```sh
sudo apt-get install ssh vim ufw -y
sudo echo "PORT 4242" >> /etc/ssh/sshd_config
sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
sudo ufw allow 4242
sudo ufw active
```

In Virtual box, go to `Settings` -> `Network` -> `Advenced` -> `Port Forwading` and add a new port protocol.

```
/*
    Protocol -> TCP
    Main Port Forwarding -> 4242
    Guest Port Forwarding -> 4242
*/
```

Then just reboot your virtual machine.

```sh
sudo reboot
```

Now you can connect to your virtual machine using your own machine's terminal.

```sh
ssh -p 4242 USER@localhost

# Or for root login

ssh -p 4242 root@localhost
```

# Getting started

Just install necessary packages for this step. Let's start with a package that runs `Makefile`

```sh
sudo apt-get install make -y
```

Let's bypass our `localhost` connection to our domain address.

```sh
sudo "127.0.0.1 YOUR_USERNAME.42.fr" >> /etc/hosts
```

Let's also install a service to update our time and date automatically. [**Source 🔗**](https://superuser.com/questions/323062/how-to-set-debian-to-automatically-update-time-and-date)

```sh
sudo apt-get install ntp -y
```

Edit your `/etc/ntp.conf` file like this:

```conf
logfile /var/log/xntpd
driftfile /var/lib/ntp/ntp.drift
statsdir /var/log/ntpstats/

statistics loopstats peerstats clockstats
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable

server pool.ntp.org
server asia.pool.ntp.org
server europe.pool.ntp.org
server north-america.pool.ntp.org
server oceania.pool.ntp.org
server south-america.pool.ntp.org
```

Then finally, reboot your virtual machine again.

```sh
sudo reboot
```

# Installing docker

## For Debian
```sh
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get remove docker-compose

sudo apt-get update

sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose -y
```

## For Ubuntu
```sh
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt-get update

sudo apt-get install ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

# End

After you finished all these, you're pretty done the project. All you need to do is edit the [**.env**](https://github.com/TeomanDeniz/Inception/blob/main/srcs/.conf) file and some other files inside of the project for cusomizing your website.

## Makefile

* `all` - Compile the server
* `clean` - Delete and reset the server
* `re` - Delete and re-compile the server
* `up` - Start the server
* `down` - Stop the server
