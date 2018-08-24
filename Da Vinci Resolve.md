Trying to get the free version running to evaluate purchasing Studio...

So far, testing http://www.danieltufvesson.com/makeresolvedeb

```
sudo apt install libssl1.0.0 libssl-dev
```
In one place it says you need to link libraries to /usr/lib, i.e.
```
sudo ln -s /lib/x86_64-linux-gnu/libssl.so.1.0.0 /usr/lib/libssl.so.10
sudo ln -s /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /usr/lib/libcrypto.so.10
```

However I'm not seeing a `libssl.so.1.0.0` in my main library folder. - Found it in /usr/lib/x86* so links not needed

Program launches and shows tour, but segfault when running.

Grasping at straws here... trying `sudo apt install mesa-vulkan-drivers libosmesa6-dev libosmesa6 libglu1-mesa-dev`

Log shows `OpenCL error -1001, GPUPropertiesUtilUnix.cpp:338.`

trying to install `nvidia-opencl-dev`

Got it working - issue was that I had blindly installed `mesa-opencl-icd` which apparently is only for AMD cards. Clue was in the stack trace, 

```
./resolve() [0x4098729]
./resolve(_ZN7BtDebug14ReportSegfaultEiP7siginfoPv+0x6c) [0x4097d2c]
/lib/x86_64-linux-gnu/libpthread.so.0(+0x12890) [0x7f87f4e4c890]
/lib/x86_64-linux-gnu/libc.so.6(cfree+0x505) [0x7f87f2ec6e55]
/opt/resolve/bin/../libs/libtbbmalloc_proxy.so.2(free+0xae) [0x7f880939905e]
/opt/resolve/bin/../libs/libc++abi.so.1(_ZNSt13runtime_errorD1Ev+0x39) [0x7f880d7fdf99]
/opt/resolve/bin/../libs/libc++abi.so.1(__cxa_decrement_exception_refcount+0x1c) [0x7f880d7faacc]
/usr/lib/x86_64-linux-gnu/libMesaOpenCL.so.1(+0x1ede89) [0x7f87e2bade89]
/usr/lib/x86_64-linux-gnu/libMesaOpenCL.so.1(+0x1bb496) [0x7f87e2b7b496]
/lib64/ld-linux-x86-64.so.2(+0x10733) [0x7f880dcfa733]
/lib64/ld-linux-x86-64.so.2(+0x151ff) [0x7f880dcff1ff]
/lib/x86_64-linux-gnu/libc.so.6(_dl_catch_exception+0x6f) [0x7f87f2f962df]
/lib64/ld-linux-x86-64.so.2(+0x147ca) [0x7f880dcfe7ca]
/lib/x86_64-linux-gnu/libdl.so.2(+0xf96) [0x7f88079fdf96]
/lib/x86_64-linux-gnu/libc.so.6(_dl_catch_exception+0x6f) [0x7f87f2f962df]
/lib/x86_64-linux-gnu/libc.so.6(_dl_catch_error+0x2f) [0x7f87f2f9636f]
/lib/x86_64-linux-gnu/libdl.so.2(+0x1735) [0x7f88079fe735]
/lib/x86_64-linux-gnu/libdl.so.2(dlopen+0x71) [0x7f88079fe051]
/usr/lib/x86_64-linux-gnu/libOpenCL.so.1(+0x423f) [0x7f87fbf5323f]
/usr/lib/x86_64-linux-gnu/libOpenCL.so.1(+0x438d) [0x7f87fbf5338d]
/usr/lib/x86_64-linux-gnu/libOpenCL.so.1(+0x48da) [0x7f87fbf538da]
/usr/lib/x86_64-linux-gnu/libOpenCL.so.1(clGetPlatformIDs+0xc3) [0x7f87fbf540d3]
./resolve() [0x9483d6]
./resolve() [0x93feda]
./resolve() [0x90923c]
./resolve() [0x90694e]
./resolve() [0x905595]
./resolve() [0x904e78]
./resolve() [0x15c0a40]
./resolve() [0xe79e74]
./resolve() [0xe79d7e]
./resolve() [0x916f55]
./resolve() [0x917fc9]
./resolve(main+0x764) [0x8fe3c4]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7) [0x7f87f2e50b97]
./resolve() [0x8fd219]
Signal Number = 11
```
