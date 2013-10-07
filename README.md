# mailtub

Access your email via a RESTful web API.

## Installation

Begn by create a droplet on [digital ocean](https://www.digitalocean.com/droplets/new). Name it `mail` and make it 512 RAM. I choose San Francisco because that is nearest me. Make it Ubuntu 12.04 x64.

Cool, now ssh in.

```bash
ssh root@DROPLET_IP_ADDRESS
```

Install vim

```bash
apt-get remove vim-tiny
apt-get install vim
```

Install git

```bash
apt-get install git-core
```

Set the root user's password.

```bash
passwd
```

Restart ssh after that.

```bash
service ssh restart
```

Add a user.

```bash
adduser signatureio
```

Give the user privileges. 

```bash
visudo
```

Add the following.

```
root    ALL=(ALL:ALL) ALL
signatureio ALL=(ALL:ALL) ALL
```

Next to be extra safe let's change the ssh rules.

```bash
vim /etc/ssh/sshd_config
```

Set or add the following settings in that sshd_config file.

```
...
Port 25999
PermitRootLogin no
AllowUsers signatureio
...
```

Restart ssh.

```bash
service ssh restart
```

Ok, logout and login as the signatureio user.

```bash
ssh signatureio@IPADDRESS
```

Install oh-my-zsh

```bash
sudo apt-get update && sudo apt-get install zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
chsh -s /bin/zsh
```

Install vundle.

```bash
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
```

Set your ~/.vimrc to look like the following.

[https://github.com/scottmotte/dotfiles/blob/master/vimrc](https://raw.github.com/scottmotte/dotfiles/master/vimrc)

Launch vim and run `:BundleInstall`.

Now, install redis.

```bash
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install tcl8.5
```

Download redis (latest at writing was 2.6.16).

```bash
wget http://download.redis.io/releases/redis-2.6.16.tar.gz
tar xzf redis-2.6.16.tar.gz
cd redis-2.6.16
make
make test
sudo make install
cd utils
sudo ./install_server.sh
```

Now start and stop it as you need.

```bash
sudo service redis_6379 start
sudo service redis_6379 stop
```

Now we can setup [haraka](http://haraka.github.io/).

Install nodejs.

```bash
sudo apt-get install python-software-properties python g++ make
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs
```

Then setup haraka.

```bash
sudo npm install -g Haraka
sudo haraka -i /etc/haraka
```

Comment out all the plugins in /etc/haraka/config/plugins.

```bash
sudo vim /etc/haraka/config/plugins
```

Add `data.redis` to the end of /etc/haraka/config/plugins.

```
data.redis
```

Setup the haraka-redis js plugin.

```bash
cd /etc/haraka/plugins
sudo npm install -g redis
sudo npm install -g microtime
sudo npm install -g redis-wstream
sudo wget https://raw.github.com/scottmotte/haraka-redis/master/data.redis.js
cd ..
sudo haraka -c .
```

Edit haraka to daemonize by default.

```bash
sudo vim /etc/haraka/config/smtp.ini
```

Uncomment the `daemonize=true` line as well as the log and pid file locations.

Start the haraka service

```bash
sudo haraka -c /etc/haraka
```

[Click here](http://beingasysadmin.wordpress.com/2013/04/16/haraka-a-nodejs-based-smtp-server/) for more detailed haraka install instructions.

All done, now you have a mail server accepting mail and dumping it into a redis database.

Exit your server and let it run.
