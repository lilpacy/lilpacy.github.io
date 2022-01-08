all: technology.html diary.html

technology.html: tech-links tech-index

tech-links:
	gfind technology -maxdepth 1 -type f -printf "%M %n %u %g %k %TY-%Tm-%Td %TH:%TM:%TS %p\n" | \
	sort -r -k6,7 | \
	cut -d " " -f 8- | \
	gxargs -I {} basename {} .html | \
	gxargs -I {} /bin/bash -c 'cat link.template | \
		LINK=technology/"`echo "{}" | \
			iconv -f UTF-8-MAC -t UTF-8 | \
			nkf -WwMQ | tr = % | tr -d "\n" | sed -e "s/%%/%/g" `" \
		TEXT="`gfind . -name "{}.html" -printf "%M %n %u %g %k %TY-%Tm-%Td %TH:%TM:%TS %p\n" | \
			cut -d " " -f 6` {}" \
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
	gfind diary -maxdepth 1 -type f -printf "%M %n %u %g %k %TY-%Tm-%Td %TH:%TM:%TS %p\n" | \
	sort -r -k6,7 | \
	cut -d " " -f 8- | \
	gxargs -I {} basename {} .html | \
	gxargs -I {} /bin/bash -c 'cat link.template | \
		LINK=diary/"`echo "{}" | \
			iconv -f UTF-8-MAC -t UTF-8 | \
			nkf -WwMQ | tr = % | tr -d "\n" | sed -e "s/%%/%/g" `" \
		TEXT="`gfind . -name "{}.html" -printf "%M %n %u %g %k %TY-%Tm-%Td %TH:%TM:%TS %p\n" | \
			cut -d " " -f 6` {}" \
		envsubst' | \
	tee tmp/diary-links

diary-index:
	cat template | \
	TITLE=Diary \
	LINKS=`cat tmp/diary-links` \
	envsubst | \
	tee diary.html
