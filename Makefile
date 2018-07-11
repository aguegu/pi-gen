DOCKER=docker
CONTAINER_NAME=pigen_work

image:
	time ${DOCKER} run --rm --privileged \
		-e IMG_NAME="${IMG_NAME}" \
		-v ${CURDIR}:/pi-gen \
		pi-gen \
		bash -e -o pipefail -c "dpkg-reconfigure qemu-user-static && cd /pi-gen; ./build.sh && rsync -av work/*/build.log deploy/"

builder:
	${DOCKER} build -t pi-gen -f builder.Dockfile .

clean:
	rm -rf work deploy
	mkdir work deploy
