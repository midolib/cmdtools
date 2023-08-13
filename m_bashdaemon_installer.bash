cd `dirname $0`
scriptname=$1

function help(){
	echo "Please use:" 1>&2
	echo '  sudo bash m_bashdaemon_installer.bash ${scriptname} install' 1>&2
	echo '  sudo bash m_bashdaemon_installer.bash ${scriptname} uninstall' 1>&2
	echo '  sudo bash m_bashdaemon_installer.bash ${scriptname} reinstall' 1>&2
}

function install(){
	mkdir -p /opt/${scriptname}/
	cp -lf ${scriptname} /opt/${scriptname}/
	cat << EOF > /lib/systemd/system/${scriptname}.service 
[Unit]
Description = ${scriptname}
[Service]
ExecStart=/bin/bash /opt/${scriptname}/${scriptname}
Restart=always
Type=simple
[Install]
WantedBy=multi-user.target
EOF
	systemctl enable ${scriptname}
	systemctl start ${scriptname}
}

function uninstall (){
	systemctl stop ${scriptname}
	systemctl disable ${scriptname}
	rm -f /lib/systemd/system/${scriptname}.service
}

function reinstall(){
	uninstall
	install
}

if [[ ! -e $1 || $2 != "" ]]; then
  help
fi

$2
