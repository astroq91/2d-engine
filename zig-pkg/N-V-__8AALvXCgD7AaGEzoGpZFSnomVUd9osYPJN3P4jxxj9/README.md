# wayland-headers packaged for the Zig build system

This is a Zig package which provides various Wayland headers needed to develop and cross-compile.

It includes:

* non-generated heaedrs for [wayland](gitlab.freedesktop.org/wayland/wayland/) (see `wayland/`)

* generated headers for [wayland-protocols](https://gitlab.freedesktop.org/wayland/wayland-protocols/) (see `wayland-protocols/`):

  * viewporter
  * xdg-shell
  * idle-inhibit-unstable-v1
  * pointer-constraints-unstable-v1
  * relative-pointer-unstable-v1
  * fractional-scale-v1
  * xdg-activation-v1
  * xdg-decoration-unstable-v1

* And headers for [libdecor](https://gitlab.freedesktop.org/libdecor/libdecor) (see `libdecor/`)

## Updating

Since this repository takes files from multiple others, we connot perform a diff directly, so the procedure is to clone all of the repos
then copy the headers over to the main folders and finally perform a diff, this way, if any of the files in said folders are different from
those in the repos it will be seen in the diff.

You may simply update the files by running `update.sh` or update and diff by running `validate.sh`, both scripts output all their contents to
the terminal as they run and both always fetch the latest version of the repos. If you discover that this repo is not up to date please open a pull
request or an issue;

Deleted files, and changes to `README.md`, `build.zig`, `.github` CI files and `.gitignore` are ignored in the diff.
