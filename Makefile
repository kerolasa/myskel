FILE_LIST = find . -mindepth 1 -name .git -prune -o -name Makefile -prune -o -name README -prune -o -type f -print

tarfile: clean
	tar czf myskel.tgz `$(FILE_LIST)`
	@echo "Extract the \`myskel.tgz' to your home directory."

clean:
	rm -f myskel.tgz
