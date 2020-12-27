# Updated dockerfile to build for kickstarter 1.3

1. You will need the NDK 1.3 to be able to build for 1.3 Kickstarter, what need to be put in the ndk_1.3 folder in the repo.
Multiple versions of the NDK is available on the Amiga Developer CD 1.2
Make sure you download and extract the correct one.
There is an image in the repo showing the folder structure.

2. If you have the NDK, you will need to build the docker image. You can use buildImage.sh

3. Afer the image is available, you can build your code with it, run the build.sh

How to use build.sh:

The build.sh configured by default to build from the "test" folder.
In the test folder, you can find the makefile where you can set the input c file, and the output binary what can be run on the Amiga.

You can run the build docker environment interactively with the run.sh script.
But normally the build.sh should be enough. It will run the build, and return the compiler output to your terminal. If everything went well, you should have the binary built with the name you set in the Makefile.


Thats it. Enjoy.

---------------

Here are some useful links:
VBCC compiler - http://sun.hasenbraten.de/vbcc/index.php?view=main
Amiga C tutorial - http://www.pjhutchison.org/tutorial/amiga_c.html
Amiga books - https://amigasourcepres.gitlab.io/page/books/booklist/

Most of these resources are for a newer kickstart version, lots of features are not exist from those tutorials in 1.3.

So far the best book I found for 1.3 is this:
Amiga C Manual - Anders Bjerin - http://aminet.net/package/dev/c/ACM_PDF



---------------------------------------------------------------

Original readme:


# DockerAmigaVbcc
Docker image for Amiga Vbbc compiler

This docker image lets you compile simple c programs for the Commodore Amiga platform.
The vbcc compiler will produce binary files for the Motorola 68000 ( It works on my Amiga 600 but it should also work on A500 and A500+ )

The image was created according to this youtube tutorial:  https://www.youtube.com/watch?v=vFV0oEyY92I , many thanks to Wei-ju Wu for his wonderful work.

## Usage
1. create a directory where your C code will be stored (lets call it myamigacprogram)
2. create the program
3. create the makefile

```
mkdir ~/myamigacprogram/
cd ~/myamigacprogram/
wget https://raw.githubusercontent.com/weiju/amiga-stuff/master/os13/openwin.c
```


now create a the makefile inside myamigacprogram with your favourite text editor, the make file should be something like this

```
CC=vc
CFLAGS=-I$(NDK_INC)
all:
  $(CC) +kick13 -c99 $(CFLAGS) -lamiga -lauto /data/openwin.c -o /data/openwin
```
    
now it's time to compile openwin.c...

```
docker run -v $HOME/myamigacprogram:/data --rm -w /data  ozzyboshi/dockeramigavbcc make
```
   
You should now see the binary executable inside your myamigacprogram, copy it to a real Amiga or emulator and run it, a simple window should appear on the screen.
Happy coding & Amiga forever