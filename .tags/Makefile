EIGEN_INCLUDE:=$(shell ./find_eigen_include_path.sh)
OPENCV_INCLUDE:=$(shell ./find_opencv_include_path.sh)
CPP_INCLUDE:=$(shell ls /usr/include/c++/* -d | sort -nr | head -1)
#FLAGS:=--languages=C,+C++ --c++-kinds=+p --fields=+iaS --extra=+q --tag-relative=yes --recurse=yes
FLAGS:=--languages=C,+C++ --c++-kinds=+p --tag-relative=yes --recurse=yes
all:
	ctags -f eigen3.tags $(FLAGS) --exclude=Eigen2Support $(EIGEN_INCLUDE)
	ctags -f opencv.tags $(FLAGS) $(OPENCV_INCLUDE) 
	ctags -f cpp_std.tags --recurse=yes $(CPP_INCLUDE)
	ctags -f mp_eos.tags $(FLAGS) --languages=c,c++ --exclude=graveyard --exclude=iOS --exclude=android --exclude=calibration --exclude=pic --exclude=thirdparty --exclude=CMakeFiles --exclude=cache ~/dev/mp_vision/ ~/dev/mp_vision-build/
