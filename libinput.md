# Compiling libinput

As experimenting on Ubuntu MATE 17.10
```
Enable source code in Software Sources
sudo apt build-dep libinput
sudo apt install ninja-build meson doxygen graphviz libgtk-3-dev check valgrind libunwind-dev
cd ~/Developer/libinput
meson . builddir
ninja -C builddir
sudo ninja install -C builddir

# set up library path to include /usr/local/lib/x86_64-linux-gnu/. Otherwise the custom version will never be loaded.
cd /etc/ld.so.conf.d
echo '/usr/local/lib/x86_64-linux-gnu' | sudo tee -a usr-local-lib.conf
sudo ldconfig
```
