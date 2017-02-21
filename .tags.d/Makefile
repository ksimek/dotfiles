#EIGEN_INCLUDE:=$(shell ./find_eigen_include_path.sh)
#OPENCV_INCLUDE:=$(shell ./find_opencv_include_path.sh)
PROJECT_INCLUDE:=$(shell ./find_project_include_path.sh $(shell cat project_paths.txt))
CPP_INCLUDE:=$(shell ls -d /usr/include/c++/* | sort -nr | head -1)
#FLAGS:=--languages=C,+C++ --c++-kinds=+p --fields=+iaS --extra=+q --tag-relative=yes --recurse=yes
FLAGS:=--languages=C,+C++ --c++-kinds=+p --tag-relative=yes --recurse=yes
all:
#	ctags -f eigen3.tags $(FLAGS) --exclude=Eigen2Support $(EIGEN_INCLUDE)
#	ctags -f opencv.tags $(FLAGS) $(OPENCV_INCLUDE) 
	ctags -f cpp_std.tags --recurse=yes $(CPP_INCLUDE)
	ctags -f project.tags $(FLAGS) $(PROJECT_INCLUDE) 
