SUMMARY = "WPE Framework OpenCDMi module for playready"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=1fe8768cbb5fd322f7d50656133549de"

require include/wpeframework-plugins.inc

DEPENDS += " playready"

SRC_URI = "git:///home/ajutras/dev/nxp/modules/OCDM-Playready;protocol=file;branch=sdp \
"
SRCREV = "${AUTOREV}"

FILES_${PN} = "${datadir}/WPEFramework/OCDM/*.drm"

RDEPENDS_${PN} += " playready-data"

