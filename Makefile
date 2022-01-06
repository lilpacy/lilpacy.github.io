all: technology.html diary.html

technology.html: tech-links tech-index

tech-links:
	find technology -type f -maxdepth 1 | \
	xargs -I {} basename {} .html | \
	xargs -I {} /bin/bash -c "cat link.template | LINK='technology/{}' TEXT='{}' envsubst" | \
	tee tmp/tech-links

tech-index:
	cat template | \
	TITLE=Technology \
	LINKS=`cat tmp/tech-links` \
	envsubst | \
	tee technology.html

diary.html: diary-links diary-index

diary-links:
	find diary -type f -maxdepth 1 | \
	xargs -I {} basename {} .html | \
	xargs -I {} /bin/bash -c "cat link.template | LINK='diary/{}' TEXT='{}' envsubst" | \
	tee tmp/diary-links

diary-index:
	cat template | \
	TITLE=Diary \
	LINKS=`cat tmp/diary-links` \
	envsubst | \
	tee diary.html
