all: technology.html

technology.html: tech-links tech-index

tech-links:
	find technology -type f | \
	xargs -I {} printf "<a href='{}'>{}</a><br />\n" | \
	tee tmp/tech-links

tech-index:
	cat template | \
	TITLE=Technology \
	LINKS=`cat tmp/tech-links` \
	envsubst | \
	tee technology.html
