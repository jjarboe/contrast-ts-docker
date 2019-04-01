Installs 3.6.0 TS instance using a standard TS no-cache installer.
Note that the installer image and license have not been included; you will
need to supply your own and possibly alter these scripts accordingly.

Steps

|Action|Comments|
|---|---|
| git clone https://github.com/jjarboe/contrast-ts-docker.git && cd contrast-ts-docker | Clone the scripts, set working directory |
| cp <path-to>/Contrast-*-NO-CACHE.sh img/ | Place installer into "img" subdir |
| cp <path-to>/contrast-*.lic context/ | Place license into "context" subdir |
| Edit Dockerfile | replace installer filename in "ENV IMAGE" line, license filename in "ENV LIC_FILE" line |
| Edit ./context/install-input | Around line 15, change *.lic filename to that used in previous step (but in /tmp directory).  Be careful not to add new lines to the file. |
| ./build | Build Docker image to be used by run script |
| ./run | Run Docker image create by build script.  See notes below regarding port and data persistence. |
| WAIT | Give TeamServer 5-10 min (or more) to fire up |
| Open http://localhost:8799/ | Do your thing in TS |
| ./stop | When it's time to shutdown |


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
