#! /bin/bash
dom=$1
url=$dom
red=`tput setaf 1`
reset=`tput sgr0`
bold=`tput bold`
maketmp()
{
	mkdir tmp_clickjacking
}

html()
{
	echo "
		<html>
		<head>
		<title>Clickjack test page</title>
		</head>
		<body>
		<p>Website is vulnerable to clickjacking!</p>
		<iframe src="$url" width="500" height="500"></iframe>
		<p>If you can see the webpage inside the box then it is vulnerable to clickjacking.</p>
		</body>
		</html>
" > tmp_clickjacking/clickjacking.html
}

file_save()
{
	read -p "Do you want to save the PoC ? (Enter = NO) : " save
		case $save in
			[yY][eE][sS]|[yY])
				mv tmp_clickjacking/clickjacking.html $PWD
				echo "saved as clickjacking.html at $PWD"
				echo "${bold}${red}press ctrl+c to exit from the script${reset}"
				sleep 2
				firefox clickjacking.html
				rm -r tmp_clickjacking
			;;
			*)
				echo "PoC not saved"
				echo "${bold}${red}press ctrl+c to exit from the script${reset}"
				firefox tmp_clickjacking/clickjacking.html
				rm -r tmp_clickjacking
		esac
}

ctrlc()
{
	echo "Deleting Temporary files"
	rm -r tmp_clickjacking
	echo "Bye"
	exit 0
}

trap 'ctrlc' 2
if [[ $# == 0 ]]; then
	echo -e "${red}${bold}Invalid Syntax${reset} \n"
	echo -e "$0 target URL \n"
	echo " Eg : $0 http://www.google.com"
else
	maketmp
	html
	file_save
fi