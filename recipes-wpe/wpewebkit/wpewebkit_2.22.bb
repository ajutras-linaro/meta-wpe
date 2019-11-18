require wpewebkit.inc

PV = "2.22+git${SRCPV}"
PR = "r0"

SRCREV ?= "${AUTOREV}"
SRC_URI = "git:///home/ajutras/dev/nxp/modules/WebKitForWayland;branch=sdp;protocol=file \
          "

DEPENDS += "libgcrypt"
PACKAGECONFIG_append = " webcrypto"

FILES_${PN} += "${libdir}/wpe-webkit-0.1/injected-bundle/libWPEInjectedBundle.so"
FILES_${PN}-web-inspector-plugin += "${libdir}/wpe-webkit-0.1/libWPEWebInspectorResources.so"
