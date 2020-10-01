#! /bin/bash

echo "Installing Golang"
wget https://golang.org/dl/go1.15.linux-amd64.tar.gz
sudo tar -xvf go1.15.linux-amd64.tar.gz
sudo mv go /usr/local
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export GOPATH=$HOME/go'	>> ~/.bashrc
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc

source ~/.bashrc

echo "installing assetfinder"
go get -u github.com/tomnomnom/assetfinder
echo "Done"
