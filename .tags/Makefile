EIGEN_INCLUDE:=$(shell ./find_eigen_include_path.sh)
OPENCV_INCLUDE:=$(shell ./find_opencv_include_path.sh)
CPP_INCLUDE:=$(shell ls /usr/include/c++/* -d | sort -nr | head -1)
all:
	ctags -f eigen3.tags --exclude=Eigen2Support --tag-relative=yes --recurse=yes $(EIGEN_INCLUDE)
	ctags -f opencv.tags --tag-relative=yes --recurse=yes $(OPENCV_INCLUDE)
	ctags -f mp_eos.tags --tag-relative=yes --recurse=yes --languages=c,c++ --exclude=thirdparty ~/dev/mp_vision/ ~/dev/mp_vision-build/
	ctags -f cpp_std.tags --recurse=yes $(CPP_INCLUDE)
