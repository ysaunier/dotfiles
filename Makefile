# Rule to initialize and update submodules
submodules:
	git submodule init
	git submodule update

# Rule to update submodules
update:
	git submodule update --remote --merge

# Rule to clean submodules
clean:
	git submodule foreach --recursive 'git clean -xdf'
	git submodule foreach --recursive 'git reset --hard'

# Run the install script
install:
	./install

.PHONY: submodules update clean install