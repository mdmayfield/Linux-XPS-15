#Compiling libinput

As experimenting on Ubuntu MATE 17.10

Enable source code in Software Sources
sudo apt build-dep libinput
sudo apt install ninja-build meson doxygen graphviz libgtk-3-dev check valgrind libunwind-dev
cd ~/Developer/libinput
meson . builddir
ninja -C builddir
sudo ninja install -C builddir
