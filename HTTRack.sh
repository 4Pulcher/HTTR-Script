#!/bin/bash

Location=$HOME/Downloads/WebCopies


# DO NOT EDIT BELOW HERE !!


if ! [ -e /usr/bin/httrack ]
then
	printf "Install HTTRack first!\n"
	exit 1
fi


if [ -e /usr/bin/konsole ]
then
	Desktop="KDE"
else
	if [ -e /usr/bin/gnome-terminal ]
	then
		Desktop="Gnome"
	else
		Desktop="?"
	fi
fi


function Confirm
{
	if [ $# -gt 0 ]
	then
		Ask="yes"
		while [ $Ask = "yes" ]
		do
			printf "\n" > /dev/tty

			Choises=""
			for Item in $@
			do
				Ch=${Item:0:1}

				eval $Ch=$Item

				printf "$Ch: $Item\n" > /dev/tty

				Choises="$Choises$Ch"
			done

			printf '\033[1;33m'"Choose ($Choises)? "'\033[0m' > /dev/tty

			read -n1 Choise

			if [[ "$Choises" =~ "$Choise" ]]
			then
				eval Result=\$$Choise

				printf "$Result"

				Ask="no"
			fi

			printf "\n" > /dev/tty
		done
	else
		Confirm "Yes" "No"
	fi
}


function Select
{
	if [ $# -gt 0 ]
	then
		printf '\033[1;33m'"\nMake a choise:"'\033[0m' > /dev/tty

		Confirm $@
	else
		Confirm
	fi
}


function HTTRack
{
	clear

	printf  '\033[1;31m'"New PROJECT:\n\n"'\033[0m'

	printf '\033[1;33m'"\tNAME:\t"'\033[0m'"$Name\n\n"'\033[1;33m'"\tURL:\t"'\033[0m'"$URL\n\n"'\033[1;33m'"\tMODE:\t"'\033[0m'"$Mode\n\n"'\033[1;33m'"\tJava:\t"'\033[0m'"$Java\n\n"'\033[1;33m'"\tDesktop:\t"'\033[0m'"$Desktop\n\n\n\n"

	sleep 2

	case $Desktop in
	"KDE")
		if [ "$Name" != "" ] && [ "$URL" != "" ] && [ "$Mode" != "" ] && [ "$Java" != "" ]
		then
			case "$Mode" in
			"normal")
				if [ "$Java" = "Yes" ]
				then
					konsole --new-tab --workdir "$Location" -e "httrack --path \"$Name\" --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=1 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent \"HTTP(S)\" --referer \"REFERER\" --from \"FROM\" --footer \"<meta app='HTTRack'>\" --language \"en, *\" --verbose --index --purge-old=0 $Subs $Extras"
					sleep 60
				else
					konsole --new-tab --workdir "$Location" -e "httrack --path \"$Name\" --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=0 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent \"HTTP(S)\" --referer \"REFERER\" --from \"FROM\" --footer \"<meta app='HTTRack'>\" --language \"en, *\" --verbose --index --purge-old=0 $Subs $Extras"
					sleep 60
				fi
				;;
			"verbose")
				if [ "$Java" = "Yes" ]
				then
					konsole --new-tab --workdir "$Location" -e "httrack --path \"$Name\" --verbose --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=1 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent \"HTTP(S)\" --referer \"REFERER\" --from \"FROM\" --footer \"<meta app='HTTRack'>\" --language \"en, *\" --verbose --index --purge-old=0 $Subs $Extras"
					sleep 60
				else
					konsole --new-tab --workdir "$Location" -e "httrack --path \"$Name\" --verbose --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=0 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent \"HTTP(S)\" --referer \"REFERER\" --from \"FROM\" --footer \"<meta app='HTTRack'>\" --language \"en, *\" --verbose --index --purge-old=0 $Subs $Extras"
					sleep 60
				fi
				;;
			"display")
				if [ "$Java" = "Yes" ]
				then
					konsole --new-tab --workdir "$Location" -e "httrack --path \"$Name\" --display --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=1 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent \"HTTP(S)\" --referer \"REFERER\" --from \"FROM\" --footer \"<meta app='HTTRack'>\" --language \"en, *\" --verbose --index --purge-old=0 $Subs $Extras"
					sleep 60
				else
					konsole --new-tab --workdir "$Location" -e "httrack --path \"$Name\" --display --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=0 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent \"HTTP(S)\" --referer \"REFERER\" --from \"FROM\" --footer \"<meta app='HTTRack'>\" --language \"en, *\" --verbose --index --purge-old=0 $Subs $Extras"
					sleep 60
				fi
				;;
			esac
		fi
		;;
	"Gnome") # "TO_DO"
		if [ "$Name" != "" ] && [ "$URL" != "" ] && [ "$Mode" != "" ] && [ "$Java" != "" ]
		then
			case "$Mode" in
			"normal")
				if [ "$Java" = "Yes" ]
				then
					gnome-terminal --tab --profile="Default" --working-directory="$Location" -- httrack --path $Name --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=1 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent 'HTTP(S)' --referer 'REFERER' --from 'FROM' --footer '<meta app="HTTRack">' --language 'en,*' --verbose --index --purge-old=0 $Subs $Extras
					sleep 60
				else
					gnome-terminal --tab --profile="Default" --working-directory="$Location" -- httrack --path $Name --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=0 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent 'HTTP(S)' --referer 'REFERER' --from 'FROM' --footer '<meta app="HTTRack">' --language 'en,*' --verbose --index --purge-old=0 $Subs $Extras
					sleep 60
				fi
				;;
			"verbose")
				if [ "$Java" = "Yes" ]
				then
					gnome-terminal --tab --profile="Default" --working-directory="$Location" -- httrack --verbose --path $Name --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=1 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent 'HTTP(S)' --referer 'REFERER' --from 'FROM' --footer '<meta app="HTTRack">' --language 'en,*' --verbose --index --purge-old=0 $Subs $Extras
					sleep 60
				else
					gnome-terminal --tab --profile="Default" --working-directory="$Location" -- httrack --verbose --path $Name --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=0 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent 'HTTP(S)' --referer 'REFERER' --from 'FROM' --footer '<meta app="HTTRack">' --language 'en,*' --verbose --index --purge-old=0 $Subs $Extras
					sleep 60
				fi
				;;
			"display")
				if [ "$Java" = "Yes" ]
				then
					gnome-terminal --tab --profile="Default" --working-directory="$Location" -- httrack --display --path $Name --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=1 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent 'HTTP(S)' --referer 'REFERER' --from 'FROM' --footer '<meta app="HTTRack">' --language 'en,*' --verbose --index --purge-old=0 $Subs $Extras
					sleep 60
				else
					gnome-terminal --tab --profile="Default" --working-directory="$Location" -- httrack --display --path $Name --mirror $URL --keep-alive --test --disable-security-limits --depth=99999 --advanced-maxlinks=16777215 --ext-depth=0 --max-rate=3000000 --sockets=4 --timeout=30 --retries=2 --structure=0 --replace-external --generate-errors --cookies=0 --check-type=2 --parse-java=0 -%P --robots=0 --tolerant --updatehack --urlhack --user-agent 'HTTP(S)' --referer 'REFERER' --from 'FROM' --footer '<meta app="HTTRack">' --language 'en,*' --verbose --index --purge-old=0 $Subs $Extras
					sleep 60
				fi
				;;
			esac
		fi
		;;
	"?")
		echo "TO_DO"
		;;
	esac
}


function GetProjects
{
	printf '\033[1;33m'"Projects:\n"'\033[0m'

	Count=0

	for Item in *
	do
		if [ "$Item" != "*" ]
		then
			if [ -d "$Item" ] && [ -d "$Item/hts-cache" ]
			then
				((Count++))

				eval Project$Count=$Item

				if [ $Count -gt 99 ]
				then
					printf "$Count: $Item\n"
				elif [ $Count -gt 9 ]
				then
					printf " $Count: $Item\n"
				else
					printf "  $Count: $Item\n"
				fi
			else
				printf "   : $Item\n"
			fi
		fi
	done

	printf "\n"

	return $Count
}


DirStart=$(pw)

[ ! -d $Location ] && mkdir -p $Location

Run=true
while ($Run)
do
	cd $Location

	clear

	printf '\033[1;33m'"\n\tMAIN MENU\n\n"'\033[0m'

	Count=0

	GetProjects

	if [ $Count -gt 0 ]
	then
		Action=`Select 'continue' 'ContinueAll' 'update' 'UpdateAll' 'xClean' 'XCleanAll' 'release' 'delete' 'new' 'quit'`
	else
		Action=`Select 'new' 'quit'`
	fi

	printf "\nAction: $Action\n\n"

	case $Action in
		"new") # Continue download:
			clear

			printf '\033[1;33m'"Create a new download?\n\n"'\033[0m'

			read -p "Enter Project-NAME or leave empty to abort: " Name

			if [ "$Name" != "" ]
			then
				printf "\n"
				
				read -p "Enter URLs: " URL

				Ask="yes"
				while [ $Ask = "yes" ]
				do
					Subs=""

					printf "\nInclude sub-domains?"

					if [ $(Confirm "yes" "no") = "yes" ]
					then
						if [[ "$URL" =~ "https://" ]]
						then
							if [[ "$URL" =~ "www." ]]
							then
								Subs="+https://*.${URL#*www.}/*"
							else
								Subs="+https://*.${URL#https://}/*"
							fi
						elif [[ "$URL" =~ "http://" ]]
						then
							if [[ "$URL" =~ "www." ]]
							then
								Subs="+http://*.${URL#*www.}/*"
							else
								Subs="+http://*.${URL#http://}/*"
							fi
						else
							if [[ "$URL" =~ "www." ]]
							then
								Subs="+*.${URL#www.}/*"
							else
								printf "\n"
								
								read -p "Enter sub-domains: " Subs
							fi
						fi
					
						printf "\nIs this correct ($Subs)?"

						if [ $(Confirm "yes" "no") = "yes" ] ; then Ask="no" ; fi
					else
						Ask="no"
					fi
				done

				clear

				printf '\033[1;33m'"Create a new download..\n\n"'\033[0m'

				Ask="yes"
				while [ $Ask = "yes" ]
				do
					Extras=""

					printf "\nInclude additional extentions?"

					if [ $(Confirm "yes" "no") = "yes" ]
					then
						case $(Select "auto" "manuel") in
						"auto")
							printf "\nInclude DOCUMENTs (doc,docx,msg,odt,pages,rtf,tex,tif,tiff,txt,wpd,wps)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.doc +*.docx +*.log +*.msg +*.odt +*.pages +*.rtf +*.tex +*.tif +*.tiff +*.txt +*.wpd +*.wps"
							fi

							printf "\nInclude AUDIOs (aif,iff,m3u,m4a,mid,mp3,mpa,mts,mats,mvts,wav,weba,wma)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.aif +*.iff +*.m3u +*.m4a +*.mid +*.mp3 +*.mpa +*.mts +*.mats +*.mvts +*.wav +*.weba +*.wma"
							fi

							printf "\nInclude VIDEOs (3g2,3gp,asf,avi,flv,m4v,mov,mp4,mpg,rm,srt,swf,vob,webm,wmv)?"
							if [ $(Confirm ) = "yes" ]
							then
								Extras+="+*.3g2 +*.3gp +*.asf +*.avi +*.flv +*.m4v +*.mov +*.mp4 +*.mpg +*.rm +*.srt +*.swf +*.vob +*.webm +*.wmv"
							fi

							printf "\nInclude 3D-Images (3dm,3ds,blend,max,obj,stl)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.3dm +*.3ds +*.blend +*.max +*.obj +*.stl"
							fi


							printf "\nInclude VECTOR-Images (ai,eps,svg)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.ai +*.eps +*.svg"
							fi

							printf "\nInclude RASTER-Images (bpg,bmp,deep,drw,ecw,fits,flif,gem,gif,hdr,heif,ico,iff,ilbm,img,jpeg,jfif,jpg,liff,,nrrd,pam,pbm,pcx,pgf,pgm,plbm,png,pnm,ppm,sgi,sid,tga,tif,tiff,webp,xisf)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.bpg +*.bmp +*.deep +*.drw +*.ecw +*.fits +*.flif +*.gem +*.gif +*.hdr +*.heif +*.ico +*.iff +*.ilbm +*.img +*.jpeg +*.jfif +*.jpg +*.liff +*.nrrd +*.pam +*.pbm +*.pcx +*.pgf +*.pgm +*.plbm +*.png +*.pnm +*.ppm +*.sgi +*.sid +*.tga +*.tif +*.tiff +*.webp +*.xisf"
							fi

							printf "\nInclude Layout-files (indd,pct,pdf)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.indd +*.pct +*.pdf"
							fi

							printf "\nInclude SPREADSHEATS (xlr,xls,xlsx)?"
							if [ $(Confirm ) = "yes" ]
							then
								Extras+="+*.xlr +*.xls +*.xlsx"
							fi

							printf "\nInclude DATABASEs (accdb,db,dbf,mdb,pdb,sql)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.accdb +*.db +*.dbf +*.mdb +*.pdb +*.sql"
							fi

							printf "\nInclude RUNABLES (apk,app,bat,cgi,com,exe,gadget,jar,swf,wsf)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.apk +*.app +*.bat +*.cgi +*.com +*.exe +*.gadget +*.jar +*.swf +*.wsf"
							fi

							printf "\nInclude ROMs (b,dem,gam,nes,rom,sav)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.b +*.dem +*.gam +*.nes +*.rom +*.sav"
							fi

							printf "\nInclude CAD-files (cad,dwg,dxf)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.cad +*.dwg +*.dxf"
							fi

							printf "\nInclude GIS-files (gis,gpx,kml,kmz)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.gis +*.gpx +*.kml +*.kmz"
							fi

							printf "\nInclude WEB-files (asp,aspx,cer,cfm,crdownload,csr,css,dcr,htm,html,js,jsp,php,rss,xhtml)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.asp +*.aspx +*.cer +*.cfm +*.crdownload +*.csr +*.css +*.dcr +*.htm +*.html +*.js +*.jsp +*.php +*.rss +*.xhtml"
							fi

							printf "\nInclude PLUGINs (crx,plugin)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.crx +*.plugin"

							fi
							printf "\nInclude SYSTEM-files (cab,cpl,cur,deskthemepack,dll,dmp,drv,icns,ico,lnk,log,sys)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.cab +*.cpl +*.cur +*.deskthemepack +*.dll +*.dmp +*.drv +*.icns +*.ico +*.lnk +*.sys"
							fi

							printf "\nInclude CONFIG-files (cfg,ini,prf)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.cfg +*.ini +*.prf"
							fi

							printf "\nInclude ENCODED-files (hqx,mim,uue)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.hqx +*.mim +*.uue"
							fi

							printf "\nInclude ARCHIVE (7z,cbr,deb,gz,pkg,rar,rpm,sitx,tar,gz,zip,zipx)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.7z +*.cbr +*.deb +*.gz +*.pkg +*.rar +*.rpm +*.sitx +*.tar +*.gz +*.zip +*.zipx"
							fi

							printf "\nInclude DISK-IMAGEs (bin,cue,dmg,iso,mdf,toast,vcd)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.bin +*.cue +*.dmg +*.iso +*.mdf +*.toast +*.vcd"
							fi

							printf "\nInclude DEVELOPMENT-files (c,class,cpp,cs,dtd,fla,h,java,lua,m,pl,py,sh,sln,swift,vb,vcxproj,xcodeproj)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.c +*.class +*.cpp +*.cs +*.dtd +*.fla +*.h +*.java +*.lua +*.m +*.pl +*.py +*.sh +*.sln +*.swift +*.vb +*.vcxproj +*.xcodeproj"
							fi

							printf "\nInclude BACKUPs (bak,tmp)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.bak +*.tmp"
							fi

							printf "\nInclude MISC-files (ics,msi,part,torrent)?"
							if [ $(Confirm) = "yes" ]
							then
								Extras+="+*.ics +*.msi +*.part +*.torrent"
							fi
							;;

						"manuel")
							printf "\n"
				
							read -p "Enter extras: " Extras
							;;
						esac

						printf '\033[1;33m'"\n\nEXTRAS: `if [ \"$Extras\" = \"\" ] ; then printf \"none\" ; else printf \"$Extras\" ; fi`\n"'\033[0m'"Is this correct?"

						if [ $(Confirm "yes" "no") = "yes" ]; then Ask="no" ; fi
					else
						Ask="no"
					fi
				done

				clear

				printf '\033[1;33m'"\nCreate a new download..\n"'\033[0m'

				printf "\nEnable 'JavaScript' analyse?"

				Java=$(Confirm "yes" "no")

				clear

				printf '\033[1;33m'"\nCreate a new download:\n"'\033[0m'

				printf "\nChoose type of output:\n"

				Mode=$(Select 'normal' 'verbose' 'display')

				clear
				
				printf '\033[1;33m'"Create a new download:\n"'\033[0m'

				printf "\nNAME: $Name\n\nURL (sub-domains): $URL ($Subs)\n\nEXTRAs: $Extras\n\nJAVA: $Java\n\nMODE: $Mode\n\n"

				printf '\033[1;31m'"\n===> Continue with httrack ?"'\033[0m'

				if [ $(Confirm "Yes" "No") = "Yes" ]
				then
					HTTRack &
				else
					printf "Aborted!\n"
				fi
				
			else
				printf "Aborted!\n"
			fi

			sleep 5
			;;
		"continue") # Continue download:
			printf '\033[1;33m'"\nContinue a download..\n"'\033[0m'"Enter projectnumber or leave empty to abort:\n"

			read -p "=> " Param

			if [ "$Param" != "" ]
			then
				eval Project=\$Project$Param

				if [ -d "$Project/hts-cache" ]
				then
					if [ $(Confirm "Yes" "No") = "Yes" ]
					then
						cd $Project

						case "$Desktop" in
						"KDE")
							konsole --new-tab --workdir "$Location/$Project" -e "httrack --continue" &
							;;
						"Gnome")
							gnome-terminal --tab --profile="Default" --working-directory="$Location/$Project" -- httrack --continue &
							;;
						"?")
							echo "TO_DO"
							;;
						esac

						printf "Started!\n"

						cd ..
					else
						printf "Aborted!\n"
					fi
				else
					printf "\nInvali project-number!\n"
				fi
			else
				printf "Aborted!\n"
			fi

			sleep 3
			;;
		"ContinueAll") # Continue all downloads:
			printf '\033[1;33m'"\nContinue all downloads?"'\033[0m'
			if [ $(Confirm "Yes" "No") = "Yes" ]
			then
				Param=0

				while [ $Param -lt $Count ]
				do
					((Param++))

					eval Project=\$Project$Param

					if [ -d "$Project/hts-cache" ]
					then
						cd $Project

						case "$Desktop" in
						"KDE")
							konsole --new-tab --workdir "$Location/$Project" -e "httrack --continue" &
							;;
						"Gnome")
							gnome-terminal --tab --profile="Default" --working-directory="$Location/$Project" -- httrack --continue &
							;;
						"?")
							echo "TO_DO"
							;;
						esac

						printf "$Project: Started!\n"

						sleep 3

						cd ..
					else
						printf "\nInvali project-number!\n"
					fi
				done
			else
				printf "Aborted!\n"
			fi

			sleep 3
			;;
		"update") # Upate a download:
			printf '\033[1;33m'"\nUpdate a download?\n"'\033[0m'"Enter projectnumber or leave empty to abort:\n"

			read -p "=> " Param

			if [ "$Param" != "" ]
			then
				eval Project=\$Project$Param

				if [ -d "$Project/hts-cache" ]
				then
					if [ $(Confirm "Yes" "No") = "Yes" ]
					then
						cd $Project

						case "$Desktop" in
						"KDE")
							konsole --new-tab --workdir "$Location/$Project" -e "httrack --update" &
							;;
						"Gnome")
							gnome-terminal --tab --profile="Default" --working-directory="$Location/$Project" -- httrack --update &
							;;
						"?")
							echo "TO_DO"
							;;
						esac

						printf "Started!\n"

						cd ..
					else
						printf "Aborted!\n"
					fi
				else
					printf "\nInvali project-number!\n"
				fi
			else
				printf "Aborted!\n"
			fi

			sleep 3
			;;
		"UpdateAll") # Continue all downloads:
			printf '\033[1;33m'"\nUpdate all downloads?\n"'\033[0m'
			if [ $(Confirm "Yes" "No") = "Yes" ]
			then
				Param=0

				while [ $Param -lt $Count ]
				do
					((Param++))

					eval Project=\$Project$Param

					if [ -d "$Project/hts-cache" ]
					then
						cd $Project

						case "$Desktop" in
						"KDE")
							konsole --new-tab --workdir "$Location/$Project" -e "httrack --update" &
							;;
						"Gnome")
							gnome-terminal --tab --profile="Default" --working-directory="$Location/$Project" -- httrack --update &
							;;
						"?")
							echo "TO_DO"
							;;
						esac

						printf "$Project: Started!\n"

						sleep 3

						cd ..
					else
						printf "\nInvali project-number!\n"
					fi
				done
			else
				printf "Aborted!\n"
			fi

			sleep 3
			;;
		"xClean") # Clean a download:
			printf '\033[1;33m'"\nClean a download?\n"'\033[0m'"Enter projectnumber or leave empty to abort:\n"

			read -p "=> " Param

			if [ "$Param" != "" ]
			then
				eval Project=\$Project$Param

				if [ -d "$Project/hts-cache" ]
				then
					if [ $(Confirm "Yes" "No") = "Yes" ]
					then
						cd $Project

						find . -name *.tmp -print -delete
						find . -empty -print -delete

						cd ..
					else
						printf "Aborted!\n"
					fi
				else
					printf "\nInvali project-number!\n"
				fi
			else
				printf "Aborted!\n"
			fi

			sleep 3
			;;
		"XCleanAll") # Continue all downloads:
			printf '\033[1;33m'"Clean all downloads?"'\033[0m'
			if [ $(Confirm "Yes" "No") = "Yes" ]
			then
				Param=0

				while [ $Param -lt $Count ]
				do
					((Param++))

					eval Project=\$Project$Param

					if [ -d "$Project/hts-cache" ]
					then
						cd $Project

						find . -name *.tmp -print -delete
						find . -empty -print -delete

						cd ..
					else
						printf "\nInvali project-number!\n"
					fi
				done
			else
				printf "Aborted!\n"
			fi

			sleep 3
			;;
		"release") # Release a download:
			printf '\033[1;33m'"\nRelease a download?\n"'\033[0m'"Enter projectnumber or leave empty to abort:\n"

			read -p "=> " Param

			if [ "$Param" != "" ]
			then
				eval Project=\$Project$Param

				if [ -d "$Project/hts-cache" ]
				then
					if [ $(Confirm "Yes" "No") = "Yes" ]
					then
						cd $Project

						for F in "hts-cache" "backblue.gif" "external.html" "fae.gif" "hts-in_progress.lock" "inex.html"
						do
							if [ -d "$F" ]
							then
								rm -v -r "$F"

							elif [ -f "$F" ]
							then
								rm -v "$F"

							else
								printf "skip: $F\n"
							fi
						done

						find . -name *.tmp -print -delete
						find . -empty -print -delete

						cd ..
					else
						printf "Aborted!\n"
					fi
				else
					printf "\nInvali project-number!\n"
				fi
			else
				printf "Aborted!\n"
			fi

			sleep 3
			;;
		"delete") # Delete a download:
			printf '\033[1;33m'"\nDelete a download?\n"'\033[0m'"Enter projectnumber or leave empty to abort:\n"

			read -p "=> " Param

			if [ "$Param" != "" ]
			then
				eval Project=\$Project$Param

				if [ -d "$Project/hts-cache" ]
				then
                    printf '\033[1;31m'"\nAre you sure?\n"'\033[0m'
					if [ $(Confirm "Yes" "No") = "Yes" ]
					then
						rm -v -r $Project
					else
						printf "Aborted!\n"
					fi
				else
					printf "\nInvali project-number!\n"
				fi
			else
				printf "Aborted!\n"
			fi

			sleep 3
			;;
		"quit") # End script:
			printf '\033[1;33m'"\nDo you want to quit?\n"'\033[0m'
			if [ $(Confirm "Yes" "No") = "Yes" ]
			then
				printf "\n\nThanks for using my script..\n"
				Run=false
			fi
			;;
		*)
			echo "\nInvalid action; try again.\n"

			sleep 1
	esac

	printf "\n"
done

exit 0
