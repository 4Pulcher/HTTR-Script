#!/bin/bash
# By Ali_ISIN

Location=$(pwd)

# DO NOT EDIT BELOW HERE !!

if [ ! -e /usr/bin/httrack ] ; then echo 'Install HTTRack first!' ; exit 1 ; fi
if [ ! -z $XDG_CURRENT_DESKTOP ] ; then Desktop=$XDG_CURRENT_DESKTOP ; else Desktop='!' ; fi

## Essentials:

# Display a selection menu and return the chosen first-letter
function Select {
	if [ $# -gt 0 ] ; then
		while true ; do
			local choices=''
			for item in "$@" ; do
				local ch=${item:0:1}
				echo "$ch: $item" > /dev/tty
				choices+=${ch}
			done
			echo -n "($choices)?" > /dev/tty ; read -n1 -r choice
			if [[ $choices =~ $choice ]] ; then
				for item in "$@" ; do
					if [ "${item:0:1}" = "$choice" ] ; then echo $item ; echo > /dev/tty ; return ; fi
				done
			else echo > /dev/tty ; echo "Invalid choice: $choice" > /dev/tty ; fi
		done
	else echo > /dev/tty ; echo 'Nothing to select from!' > /dev/tty ; fi
}

function Confirm { if [ $# -gt 0 ] ; then Select "$@" ; else Select 'yes' 'no' ; fi }

## Ask if sub-domains included..
function GetSubs {
	while true ; do
		Subs=''
		echo > /dev/tty
		echo 'Include sub-domains?' > /dev/tty
		if [ $(Confirm) = 'yes' ] ; then
			if [ ${URL:0:8} = 'https://' ] ; then
				if [ ${URL:8:4} = 'www.' ] ; then Subs="+https://*.${URL#*.}/*"
				else Subs="+https://*.${URL#*//}/*"
				fi
			elif [ ${URL:0:7} = 'http://' ] ; then
				if [ ${URL:7:4} = 'www.' ] ; then Subs="+http://*.${URL#*.}/*"
				else Subs="+http://*.${URL#*//}/*"
				fi
			else
				if [ ${URL:0:4} = 'www.' ] ; then Subs="+*.${URL#*.}/*"
				else echo > /dev/tty ; read -p 'Enter sub-domains: ' Subs > /dev/tty ; fi
			fi
			echo > /dev/tty
			echo "Is this correct ($Subs)?" > /dev/tty
			if [ $(Confirm) = 'yes' ] ; then echo $Subs ; return ; fi
		else return ; fi
	done
}

## Ask what to include
function GetExtras {
	while true ; do
		Extras=''
		echo > /dev/tty
		echo 'Include additional extentions?' > /dev/tty
		if [ $(Confirm) = 'yes' ] ; then
			declare -A additions=(
				['Documents']='+*.doc +*.docx +*.log +*.msg +*.odt +*.pages +*.rtf +*.tex +*.tif +*.tiff +*.txt +*.wpd +*.wps'
				['Audio']=' +*.aif +*.iff +*.m3u +*.m4a +*.mid +*.mp3 +*.mpa +*.mts +*.mats +*.mvts +*.wav +*.weba +*.wma'
				['Video']=' +*.3g2 +*.3gp +*.asf +*.avi +*.flv +*.m4v +*.mov +*.mp4 +*.mpg +*.rm +*.srt +*.swf +*.vob +*.webm +*.wmv'
				['3D']=' +*.3dm +*.3ds +*.blend +*.max +*.obj +*.stl'
				['Images(vector)']=' +*.ai +*.eps +*.svg'
				['Images(raster)']=' +*.bpg +*.bmp +*.deep +*.drw +*.ecw +*.fits +*.flif +*.gem +*.gif +*.hdr +*.heif +*.ico +*.iff +*.ilbm +*.img +*.jpeg +*.jfif +*.jpg +*.liff +*.nrrd +*.pam +*.pbm +*.pcx +*.pgf +*.pgm +*.plbm +*.png +*.pnm +*.ppm +*.sgi +*.sid +*.tga +*.tif +*.tiff +*.webp +*.xisf'
				['Layouts']=' +*.indd +*.pct +*.pdf'
				['Spreadsheats']=' +*.xlr +*.xls +*.xlsx'
				['Databases']=' +*.accdb +*.db +*.dbf +*.mdb +*.pdb +*.sql'
				['Runnables']=' +*.apk +*.app *.appimage +*.bat +*.cgi +*.com +*.exe +*.gadget +*.jar +*.swf +*.wsf'
				['ROMs']=' +*.b +*.dem +*.gam +*.nes +*.rom +*.sav'
				['CAD(files)']=' +*.cad +*.dwg +*.dxf'
				['GIS(files)']=' +*.gis +*.gpx +*.kml +*.kmz'
				['WEB(files)']=' +*.asp +*.aspx +*.cer +*.cfm +*.crdownload +*.csr +*.css +*.dcr +*.htm +*.html +*.js +*.jsp +*.php +*.rss +*.xhtml'
				['Plugins']=' +*.crx +*.plugin'
				['System(files)']=' +*.cab +*.cpl +*.cur +*.deskthemepack +*.dll +*.dmp +*.drv +*.icns +*.ico +*.lnk +*.sys'
				['Configurations']=' +*.cfg +*.ini +*.prf'
				['Encoded']=' +*.hqx +*.mim +*.uue'
				['Archives']=' +*.7z +*.cbr +*.deb +*.gz +*.pkg +*.rar +*.rpm +*.sitx +*.tar +*.gz +*.zip +*.zipx'
				['Disk(images)']=' +*.bin +*.cue +*.dmg +*.iso +*.mdf +*.toast +*.vcd'
				['Development(files)']=' +*.c +*.class +*.cpp +*.cs +*.dtd +*.fla +*.h +*.java +*.lua +*.m +*.pl +*.py +*.sh +*.sln +*.swift +*.vb +*.vcxproj +*.xcodeproj'
				['Backups']=' +*.bak +*.tmp'
				['Misc']=' +*.ics +*.msi +*.part +*.torrent'
			)
			echo > /dev/tty
			echo 'Additional extentions:' > /dev/tty
			case $(Select 'auto' 'confirm' 'manuel') in
			'auto') for Key in ${!additions[@]} ; do Extras+=${additions[$Key]} ; done ;;
			'confirm')
				for Key in ${!additions[@]} ; do
					local list=${additions[$Key]}
					echo > /dev/tty
					echo "Include: ($Key) $list?" > /dev/tty
					if [ $(Confirm) = 'yes' ] ; then Extras+=$list ; fi
				done
				;;
			'manuel') echo > /dev/tty ; read -p 'Enter extras: ' Extras > /dev/tty ;;
			esac
			echo "EXTRAS: $(if [ -z $Extras ] ; then echo -n 'none' ; else echo -n $Extras ; fi)" > /dev/tty
			echo > /dev/tty
			echo 'Is this correct?' > /dev/tty
			if [ $(Confirm) = 'yes' ] ; then echo -n $Extras ; return ; fi
		else return ; fi
	done
}

## Get Java-option
function GetOptionJava {
	echo > /dev/tty
	echo 'Enable "JavaScript" analyse?' > /dev/tty
	if [ $(Confirm) = 'yes' ] ; then echo -n '1'
	else echo -n '0' ; fi
}

## Get Verbose-option
function GetOptionVerbose {
	echo > /dev/tty
	echo 'Output verbose: ' > /dev/tty
	if [ $(Confirm) = 'yes' ] ; then echo -n '--verbose' ; fi
}

## Get Display-option
function GetOptionDisplay {
	echo > /dev/tty
	echo 'Output display: ' > /dev/tty
	if [ $(Confirm) = 'yes' ] ; then echo -n '--display' ; fi
}

## New project:
function CreateNew {
	echo ; echo 'Create a new download?'
	read -p 'Enter projectnumber or leave empty to abort: ' Name
	if [ ! -z $Name ] ; then
		read -p 'Enter the website URL: ' URL
		Subs=$(GetSubs)
		Extras=$(GetExtras)
		Java=$(GetOptionJava)
		Verbose=$(GetOptionVerbose)
		Display=$(GetOptionDisplay)
		clear
		echo 'Create a new download:'
		echo ; echo "NAME	: $Name"
		echo ; echo "URL	: $URL"
		echo "SubDomains	: $Subs"
		echo ; echo "Extras	: $Extras"
		echo ; echo -n "Java	: " ; echo $(if [ $Java = '0' ] ; then echo 'no' ; else echo 'yes' ; fi)
		echo -n 'Verbose	: ' ; echo $(if [ -z $Verbose ] ; then echo 'no' ; else echo 'yes' ; fi)
		echo -n 'Display	: ' ; echo $(if [ -z $Display ] ; then echo 'no' ; else echo 'yes' ; fi)

		echo ; echo '===> Continue with HTTRack?'
		if [ $(Confirm 'Yes' 'No') = 'Yes' ] ; then
			if [ ! -z $Name ] && [ ! -z $URL ] && [ ! -z $Java ] ; then
				case ${Desktop^^} in
				'GNOME') gnome-terminal --window --working-directory=$Location --name="$Project" -- httrack --path $Name --mirror $URL $Verbose $Display --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=$Java -%P --robots=0 --tolerant --updatehack --urlhack --user-agent 'HTTP(S)' --referer 'REFERER' --from 'FROM' --footer '<meta app=\"HTTRack\">' --language 'en,*' --index --purge-old=0 $Subs $Extras & ;;
				'KDE')  konsole --separate --workdir "$Location" -e "httrack --path $Name --mirror $URL $Verbose $Display --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=$Java -%P --robots=0 --tolerant --updatehack --urlhack --user-agent 'HTTP(S)' --referer 'REFERER' --from 'FROM' --footer '<meta app=\"HTTRack\">' --language 'en,*' --index --purge-old=0 $Subs $Extras" & ;;
				esac
			fi
			sleep 10
		else echo 'Aborted!' ; fi
	else echo 'Aborted!' ; fi
}

## Continue project
function ContinueOne {
	echo ; echo 'Continue a download?'
	read -p 'Enter projectnumber or leave empty to abort: ' Param
	if [ ! -z $Param ] ; then
		eval Project=\$Project$Param
		if [ -d "$Project/hts-cache" ] ; then
			echo "Continue ($Project)?"
			if [ $(Confirm 'Yes' 'No') = 'Yes' ] ; then
				case ${Desktop^^} in
				'GNOME') gnome-terminal --window --working-directory=$Location/$Project --name="$Project" -- httrack --continue & ;;
				'KDE') konsole --separate --workdir "$Location/$Project" -e "httrack --continue" & ;;
				esac
			else echo 'Aborted!' ; fi
		else echo 'Invali project-number!' ; fi
	else echo 'Aborted!' ; fi
}

## Continue all projects
function ContinueAll {
	echo ; echo 'Continue all downloads:'
	echo 'Continue? '
	if [ $(Confirm 'Yes' 'No') = 'Yes' ] ; then
		Param=0
		while [ $Param -lt $Count ] ; do
			((Param++))
			eval Project=\$Project$Param
			if [ -d "$Project/hts-cache" ] ; then
				echo "$Project: Starting.."
				case ${Desktop^^} in
				'GNOME') gnome-terminal --window --working-directory=$Location/$Project --name="$Project" -- httrack --continue & ;;
				'KDE') konsole --separate --workdir "$Location/$Project" -e "httrack --continue" & ;;
				esac
			else echo 'Invali project-number!' ; fi
		done
	else echo 'Aborted!' ; fi
}

## Upate one project
function UpdateOne {
	echo ; echo 'Update a download:'
	read -p 'Enter projectnumber or leave empty to abort: ' Param
	if [ ! -z $Param ] ; then
		eval Project=\$Project$Param
		if [ -d "$Project/hts-cache" ] ; then
			echo "Continue ($Project)?"
			if [ $(Confirm 'Yes' 'No') = 'Yes' ] ; then
				case ${Desktop^^} in
				'GNOME') gnome-terminal --window --working-directory="$Location/$Project" --name="$Project" -- httrack --update & ;;
				'KDE') konsole --separate --workdir "$Location/$Project" -e "httrack --update" & ;;
				esac
			else echo 'Aborted!' ; fi
		else echo 'Invali project-number!' ; fi
	else echo 'Aborted!' ; fi
}

## Continue all project
function UpdateAll {
	echo ; echo 'Update all downloads:'
	echo 'Continue? '
	if [ $(Confirm 'Yes' 'No') = 'Yes' ] ; then
		Param=0
		while [ $Param -lt $Count ] ; do
			((Param++))
			eval Project=\$Project$Param
			if [ -d "$Project/hts-cache" ] ; then
				echo "Starting ($Project).."
				case ${Desktop^^} in
				'GNOME') gnome-terminal --window --working-directory="$Location/$Project" --name="$Project" -- httrack --update & ;;
				'KDE') konsole --separate --workdir "$Location/$Project" -e "httrack --update" & ;;
				esac
			else echo 'Invali project-number!' ; fi
		done
	else echo 'Aborted!' ; fi
}

## Clean one project
function CleanOne {
	echo ; echo 'Clean a download?'
	read -p 'Enter projectnumber or leave empty to abort: ' Param
	if [ ! -z $Param ] ; then
		eval Project=\$Project$Param
		if [ -d "$Project/hts-cache" ] ; then
			echo "Continue ($Project)?"
			if [ $(Confirm 'Yes' 'No') = 'Yes' ] ; then
				cd "$Project"
				find . -name *.tmp -print -delete
				find . -empty -print -delete
				cd ..
			else echo 'Aborted!' ; fi
		else echo 'Invali project-number!' ; fi
	else echo 'Aborted!'; fi
}

## Clean all projects
function CleanAll {
	echo ; echo 'Clean all downloads:'
	echo 'Continue?'
	if [ $(Confirm 'Yes' 'No') = 'Yes' ] ; then
		Param=0
		while [ $Param -lt $Count ] ; do
			((Param++))
			eval Project=\$Project$Param
			if [ -d "$Project/hts-cache" ] ; then
				cd "$Project"
				find . -name *.tmp -print -delete
				find . -empty -print -delete
				cd ..
			else echo 'Invali project-number!' ; fi
		done
	else echo 'Aborted!' ; fi
}

## Release one project
function ReleaseOne {
	echo ; echo 'Release a download?'
	read -p 'Enter projectnumber or leave empty to abort: ' Param
	if [ ! -z $Param ] ; then
		eval Project=\$Project$Param
		if [ -d "$Project/hts-cache" ] ; then
			echo "Continue ($Project)?"
			if [ $(Confirm "Yes" "No") = "Yes" ] ; then
				cd "$Project"
				for F in "hts-cache" "backblue.gif" "external.html" "fae.gif" "hts-in_progress.lock" "inex.html" ; do
					if [ -d "$F" ] ; then rm -v -r "$F"
					elif [ -f "$F" ] ; then rm -v "$F"
					else echo "Skip: $F[N]" ; fi
				done
				find . -name *.tmp -print -delete
				find . -empty -print -delete
				cd ..
			else echo 'Aborted!' ; fi
		else echo 'Invali project-number!' ; fi
	else echo 'Aborted!' ; fi
}

## Delete one project
function DeleteOne {
	echo ; echo 'Delete a download?'
	read -p 'Enter projectnumber or leave empty to abort: ' Param
	if [ ! -z $Param ] ; then
		eval Project=\$Project$Param
		if [ -d "$Project/hts-cache" ] ; then
			echo "Are you sure ($Project)?"
			if [ $(Confirm "Yes" "No") = "Yes" ] ; then
				rm -v -r $Project
			else echo 'Aborted!' ; fi
		else echo 'Invali project-number!' ; fi
	else echo 'Aborted!' ; fi
}

## Get a list of projects
function GetProjects {
	if [ ! -d "$Location" ] ; then mkdir -p "$Location" ; fi
	cd "$Location"
	echo ; echo "Projects:" ; echo
	for Item in * ; do
		if [ "$Item" != "*" ] ; then
			if [ -d "$Item" ] && [ -d "$Item/hts-cache" ] ; then
				((Count++))
				eval Project$Count=$Item
				echo "$Count	: $Item"
			else echo "-	: $Item" ; fi
		fi
	done
}

## MAIN-FUNCTION
DirStart=$(pwd)
while true ; do
	clear ; echo ; echo ; echo "	MAIN MENU"  > /dev/tty
	Count=0 ; GetProjects
	echo ; echo "Make a choise:"
	if [ $Count -gt 0 ] ; then Action=$(Select 'continue' 'ContinueAll' 'update' 'UpdateAll' 'xClean' 'XCleanAll' 'Release' 'Delete' 'New' 'Quit')
	else Action=$(Select 'New' 'Quit')
	fi
	echo ; echo "Action: $Action"
	case $Action in
		'New') CreateNew ; sleep 5 ;;
		'continue') ContinueOne ; sleep 5 ;;
		'ContinueAll') ContinueAll ; sleep 5 ;;
		'update') UpdateOne ; sleep 5 ;;
		'UpdateAll') UpdateAll ; sleep 5 ;;
		'xClean') CleanOne ; sleep 5 ;;
		'XCleanAll') CleanAll ; sleep 5 ;;
		'Release') ReleaseOne ; sleep 5 ;;
		'Delete') DeleteOne ; sleep 5 ;;
		'Quit') # End script:
			echo ; echo "Do you want to quit?"
			if [ $(Confirm "Yes" "No") = "Yes" ] ; then
				echo $DirStart
				echo ; echo "Thanks for using my script.." ; echo
				exit 0
			fi
			;;
		*) echo ; echo "Invalid action; try again." ; sleep 2 ;;
	esac
done
