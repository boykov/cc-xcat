fix_locale:
	docker exec -d cc-xcat-ubuntu-x86_64 sed -i "s|AcceptEnv LANG LC_*|# AcceptEnv LANG LC_*|" /etc/ssh/sshd_config
	docker exec -d cc-xcat-ubuntu-x86_64 service ssh restart

run:
	docker run -it -h cc-xcat-mgt.cluster --name cc-xcat-ubuntu-x86_64 --detach xcat/xcat-ubuntu-x86_64 bash

clear:
	docker rm -f cc-xcat-ubuntu-x86_64 || true
