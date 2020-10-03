# Web-recon

This tool is created as a part of learning shell scripting, now I am making various changes to make it a better tool which can be used to collect various information of a website.
# Current features

  - Can collect subdomains of a website
  - Can collect CNAME record of the subdomains
  - Can Check for Clickjacking vulnerability

### Installation

```sh
$ git clone https://github.com/secretguard/web-recon.git
$ cd web-recon
$ ./install.sh
```


### Usage

```sh
$ ./web-recon.sh -h
$ ./web-recon.sh -d domain_name
```

![web-recon_demo](https://user-images.githubusercontent.com/57167283/94853961-cb029580-0449-11eb-8dbe-d98d1bb29275.gif)

### To check for clickjacking vulnerability

```sh
$ ./clickjacking.sh URL

Eg : ./clickjacking.sh https://example.com
```
