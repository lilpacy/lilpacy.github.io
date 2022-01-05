all: technology.html

technology.html: tech-links tech-index

tech-links:
	find technology -type f -maxdepth 1 | \
	xargs -I {} basename {} | \
	xargs -I {} /bin/bash -c "cat link.template | LINK='technology/{}' TEXT='{}' envsubst" | \
	tee tmp/tech-links

tech-index:
	cat template | \
	TITLE=Technology \
	LINKS=`cat tmp/tech-links` \
	envsubst | \
	tee technology.html
