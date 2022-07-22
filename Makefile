download-app:
	bash ./scripts/download-app.sh

deploy-app:
	bash ./scripts/deploy-app.sh

setup-servers:
	bash ./scripts/setup-servers.sh

deploy-nginx:
	bash ./scripts/deploy-nginx.sh

download-nginx:
	bash ./scripts/download-nginx.sh

deploy-mysql:
	bash ./scripts/deploy-mysql.sh

download-mysql:
	bash ./scripts/download-mysql.sh

deploy-all:
	$(MAKE) deploy-app
	$(MAKE) deploy-nginx
	$(MAKE) deploy-mysql
