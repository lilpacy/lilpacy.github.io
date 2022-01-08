all: technology.html diary.html

technology.html: tech-links tech-index

tech-links:
	find technology -type f -maxdepth 1 | \
	xargs -I {} basename {} .html | \
	xargs -I {} /bin/bash -c 'cat link.template | \
		LINK=technology/"`echo "{}" | \
			iconv -f UTF-8-MAC -t UTF-8 | \
			nkf -WwMQ | tr = % | tr -d "\n" | sed -e "s/%%/%/g" `" \
		TEXT="{}" \
		envsubst' | \
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
	xargs -I {} /bin/bash -c 'cat link.template | \
		LINK=diary/"`echo "{}" | \
			iconv -f UTF-8-MAC -t UTF-8 | \
			nkf -WwMQ | tr = % | tr -d "\n" | sed -e "s/%%/%/g" `" \
		TEXT="{}" \
		envsubst' | \
	tee tmp/diary-links

diary-index:
	cat template | \
	TITLE=Diary \
	LINKS=`cat tmp/diary-links` \
	envsubst | \
	tee diary.html
