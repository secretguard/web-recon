#! /bin/bash
#Author : Sarath G
#variables
dom=$2	
red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`
bold=`tput bold`
arrow=$(echo -e ${bold}"\u27F6")
space=$(echo -e ${bold}"\u0020")
time=$(echo -e ${bold}"\U23F3")
thumbs=$(echo -e ${bold}"\U1F44D")
bye=$(echo -e ${bold}"\U1F44B")

#Creating temporary file for saving data
maketmp(){
mkdir -p tmp_dom
touch tmp_dom/tmp_subdomains.txt
touch tmp_dom/tmp_cnames.txt
}
#collecting subdomains
collect_subs(){
assetfinder -subs-only $dom | tee tmp_dom/tmp_subdomains.txt
count=$(cat tmp_dom/tmp_subdomains.txt | wc -l)
echo "Total ${count} Subdomains found"
read -p "Do you want to save the subdomains[ENTER = NO] ? " sub_save
case $sub_save in
	[yY][eE][sS]|[yY])
	if [[ ! -d $dom ]]; then
		mkdir "$dom"
		cp -r tmp_dom/tmp_subdomains.txt $dom/subdomains.txt
	fi
	;;
	*)
	echo "Subdomains not Saved"
	;;
esac
}
#collecting CNAME records of all subdomains
cname_check(){
echo "Collecting CNAME records ${time} ${reset}"
	while read line
do
    name=$line
    cname=$(dig $line CNAME +short)

    if [[ -z "$cname" ]]; then
    	echo -e CNAME of ${bold}${red}$line${reset} NOT FOUND
    else
    	echo -e ${bold}${green}$line${reset} ${arrow} ${space} ${bold}${blue}$cname${reset}
    	echo -e "CNAME of ${line} : ${cname} \n" >> tmp_dom/tmp_cnames.txt
    fi
    
    
done < tmp_dom/tmp_subdomains.txt
read -p "Do you want to save the list CNAMEs [ENTER = NO] ? " cname_save
case $cname_save in
	[yY][eE][sS]|[yY])
	if [[ ! -d $dom ]]; then
		mkdir $dom
		mv tmp_dom/tmp_cnames.txt $dom/cnamerecords.txt
	else
		mv tmp_dom/tmp_cnames.txt $dom/cnamerecords.txt
	fi
	;;
esac
}

#Cleaning Temporary files
clean_tmp(){
rm -r tmp_dom
echo "Script execution completed ${thumbs}"
}

#help Message
help_msg(){
    cat <<EOF2
Usage: $0 [option]

-d <domain>  Find subdomains of <domain> and gather their CNAME records.
-h           Show this help message.
EOF2
}

ctrlc(){
echo -e " \n ${red}${bold}Keyboard Interrupt detected${reset}"
echo "Deleting Temporary files"
clean_tmp
echo "Bye ${bye} ${reset}"
exit
}

#main_part

trap 'ctrlc' 2
if [[ $# == 0 ]]; then
	echo "Invalid Syntax. $0 -h to show help"
else
	
	case $1 in
        -d )
        if [[ -z "$2" ]]; then
                echo "Domain name missing. Use $0 -h for help"
                exit 1
        fi
        start_time=$(date +%s)
        maketmp
        collect_subs
	cname_check
	clean_tmp
	finish_time=$(date +%s)
	echo "Time duration: $((finish_time - start_time)) secs."
	;;
	#-f )
	# maketmp
	# cname_check
	# clean_tmp
	# ;;
	-h )
	help_msg
	 ;;
	* )
	echo "Invalid Syntax. $0 -h to show help"
	exit
esac
fi
