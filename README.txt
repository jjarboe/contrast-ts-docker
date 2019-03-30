Installs 3.6.0 TS instance using a standard TS no-cache installer.
Note that the installer image and license have not been included; you will
need to supply your own and possibly alter these scripts accordingly.

tl;dr
1. cp <path-to>/Contrast-*-NO-CACHE.sh img/
2. cp <path-to>/contrast-*.lic context/
3. Edit Dockerfile: replace installer filename in "ENV IMAGE" line
4. Edit Dockerfile: replace license filename in "ENV LIC_FILE" line
5. Edit ./context/install-input to point use your license filename
6. ./build
7. ./run
8. Give TeamServer 5-10 min to fire up, go to http://localhost:8799/
9. Do your thing in TS
10. (when it's time to shutdown) ./stop


You may need to increase the resources available to the VM under which
Docker runs (on non-Linux hosts).  On my mac, I click on the Docker tray icon,
open "Preferences", and the "Advanced" tab.  I've probably gone overboard,
but I allocated 6 CPUs, 8GB RAM, 2.5 GB swap.  If your TS seems to shutdown
randomly, this is likely necessary.

The installer image will normally be placed into the img/ subdirectory, and
have a filename matching the pattern Contrast-*-NO-CACHE.sh.  You probably
only want one such file in img.

The license should be placed into the context/ subdirectory, and typically
has a filename matching the pattern contrast-<date>.lic.

The build script should be run from this directory, and will build a local
docker image named contrast:v3.6.  It defaults to bypassing the build cache.
You can remove the --no-cache option in build to enable the cache.

The run script should be run from this directory, and will launch an instance
based on the contrast:v3.6 image created by the build script.

You can modify the run script to change the local port used by the TS.

The run script will extract the TS install directory into the live-fs
directory on the local machine.  You have the ability to modify the
contents of this directory if desired, but keep in mind that the TS process
will be running in a container, not in a native context.  In particular, this
means that the hostname will not (and should not) match the local machine.
The run script sets the hostname of the container to ensure that TS can
connect to the database, for example.
