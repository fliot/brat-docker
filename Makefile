build:
	docker build . -t brat
	
run:
	docker run -p 80:80 -v ${PWD}/brat-data:/bratdata -v ${PWD}/brat-cfg:/bratcfg -e BRAT_USERNAME=brat -e BRAT_PASSWORD=brat -e BRAT_EMAIL=brat@example.com brat
