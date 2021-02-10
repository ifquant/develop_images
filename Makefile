#please use make base -B option
all: base develop jupyter
	echo "finish"
base:
	cd base && docker build -t base:dev . && cd ..
develop: base
	cd develop && docker build -t base:dev.lang . && cd ..
jupyter: develop
	cd jupyter && docker build -t base:dev.lang.jupyter && cd ..
