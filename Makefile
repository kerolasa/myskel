FILE_LIST = find . -mindepth 1 -name .git -prune \
			    -o -name Makefile -prune \
			    -o -name README -prune \
			    -o -name .gitignore -prune \
			    -o -type f -print

GIT_DESC = git describe

tarfile: clean
	sed -i "s/__GIT_DESCRIBE/`$(GIT_DESC)`/" .bashrc
	sed -i "s|xxxHOMExxx|$(HOME)|" .joerc .config/user-dirs.conf
	tar czf myskel.tgz `$(FILE_LIST)`
	@echo "Extract the 'myskel.tgz' to your home directory."
	@echo "Remember to run make clean sometime soon."

clean:
	git clean -xdf
	git reset --hard
