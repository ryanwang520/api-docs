.PHONY:  build deploy


start:
	docker run --rm --name slate -p 4567:4567 -v `pwd`/source:/srv/slate/source slatedocs/slate serve

build:
	docker run --rm --name slate_build -v `pwd`/docs:/srv/slate/build -v `pwd`/source:/srv/slate/source slatedocs/slate build

deploy:build
	REMOTE=$REMOTE ./deploy.sh --push-only
