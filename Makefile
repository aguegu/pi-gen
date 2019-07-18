IMG_NAME := hunterio
APT_PROXY := http://192.168.1.22:3142

image:
	time docker run --rm --privileged \
		-e IMG_NAME="${IMG_NAME}" \
		-e APT_PROXY="${APT_PROXY}" \
		-v ${CURDIR}:/pi-gen \
		pi-gen \
		bash -e -o pipefail -c "dpkg-reconfigure qemu-user-static && cd /pi-gen; ./build.sh && rsync -av work/*/build.log deploy/"

builder:
	docker build -t pi-gen .

skipall:
	for d in stage*/ ; do \
		touch "$$d/SKIP"; \
		[ -f "$$d/EXPORT_IMAGE" ] && touch "$$d/SKIP_IMAGES"; \
	done

stage0:
	echo $@
	${MAKE} skipall
	rm -f $@/SKIP
	${MAKE} image

stage1:
	echo $@
	${MAKE} skipall
	rm -f $@/SKIP
	${MAKE} image

stage2:
	echo $@
	${MAKE} skipall
	rm -f $@/SKIP
	${MAKE} image

stage6:
	echo $@
	sudo rm -rf work/*${IMG_NAME}/$@
	${MAKE} skipall
	rm -f $@/SKIP
	rm -f $@/SKIP_IMAGES
	${MAKE} image

clean:
	rm -rf work deploy
	mkdir work deploy

.PHONY: image builder skipall clean stage0 stage1 stage2 stage6
