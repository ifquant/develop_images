#please use make base -B option
all: base develop
	echo "finish"
base:
	cd base && docker build -t base:dev . && cd ..
develop:
	cd develop && docker build -t base:dev.lang . && cd ..
