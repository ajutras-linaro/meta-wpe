# bbappend for raspberryPi
#
PACKAGECONFIG_rpi = "incapp inctest increndergl incsbprotocol xdgv4"
CXXFLAGS_append_rpi = " -DWESTEROS_PLATFORM_RPI -DWESTEROS_INVERTED_Y -DBUILD_WAYLAND -I${STAGING_INCDIR}/interface/vmcs_host/linux"

do_configure_prepend_rpi() {
    sed -i -e 's/-lwesteros_simplebuffer_client/-lwesteros_compositor -lwesteros_simplebuffer_client/g' ${S}/rpi/westeros-sink/Makefile.am
}

do_compile_prepend_rpi () {
	export WESTEROS_COMPOSITOR_EXTRA_LIBS="-lEGL -lGLESv2 -lbcm_host -lvchostif"
}

# bbappend for DRM support
#
PACKAGECONFIG_hikey-32 = "incapp inctest increndergl incsbprotocol xdgv5"
CXXFLAGS_append_hikey-32 = " -DWESTEROS_PLATFORM_DRM"

do_configure_prepend_hikey-32() {
    sed -i -e 's/-lwesteros_simplebuffer_client/-lwesteros_compositor -lwesteros_simplebuffer_client/g' ${S}/drm/westeros-sink/Makefile.am
}

PACKAGECONFIG_dragonboard-410c-32 = "incapp inctest increndergl incsbprotocol xdgv5"
CXXFLAGS_append_dragonboard-410c-32 = " -DWESTEROS_PLATFORM_DRM"

do_configure_prepend_dragonboard-410c-32() {
    sed -i -e 's/-lwesteros_simplebuffer_client/-lwesteros_compositor -lwesteros_simplebuffer_client/g' ${S}/drm/westeros-sink/Makefile.am
}

PACKAGECONFIG_dragonboard-820c-32 = "incapp inctest increndergl incsbprotocol xdgv5"
CXXFLAGS_append_dragonboard-820c-32 = " -DWESTEROS_PLATFORM_DRM"

do_configure_prepend_dragonboard-820c-32() {
    sed -i -e 's/-lwesteros_simplebuffer_client/-lwesteros_compositor -lwesteros_simplebuffer_client/g' ${S}/drm/westeros-sink/Makefile.am
}

SRC_URI += "file://Enable-mouse-pointer-clicking.patch"

## configuration changes for NXP iMX8MQ
SRC_URI_append_mx8 = " file://typecast-error-resolved.patch"

westeros-soc_mx8 = "westeros-soc-drm"

PACKAGECONFIG_remove_mx8 = "xdgv4 x11"
PACKAGECONFIG_append_mx8 = " xdgv5"

do_compile_prepend_mx8() {
   ln -sf libEGL.so ${STAGING_DIR_TARGET}/${libdir}/libwayland-egl.so
}

do_install_append_mx8() {
   # wayland-egl library softlink pointing to EGL library
   rm ${STAGING_DIR_TARGET}/${libdir}/libwayland-egl.so
   ln -sf libEGL.so ${D}/${libdir}/libwayland-egl.so

   # enable cursor on launch
   sed -i -e 's/render_gl.so.0/render_gl.so.0 --enableCursor/g' ${D}/${bindir}/westeros-init
   # insert before 'exec' command which launches westeros
   sed -i -e '/exec/ i export LD_PRELOAD=/usr/lib/libwesteros_gl.so.0' ${D}/${bindir}/westeros-init

   # resolve typo error
   sed -i -e 's/Westersos/Westeros/g' ${D}/${systemd_unitdir}/system/westeros.service
}
