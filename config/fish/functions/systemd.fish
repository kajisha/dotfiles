function sc-disable
	sudo systemctl disable $argv;
end

function sc-enable
	sudo systemctl enable $argv;
end

function sc-list-unit-files
	systemctl list-unit-files $argv;
end

function sc-restart
	sudo systemctl restart $argv;
end

function sc-show
	systemctl show $argv;
end

function sc-start
	sudo systemctl start $argv;
end

function sc-status
	systemctl status $argv;
end
