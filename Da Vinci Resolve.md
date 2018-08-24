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
