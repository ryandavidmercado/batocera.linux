################################################################################
#
# LIBRETRO-KRONOS
#
################################################################################
# Version.: Commits on Oct 16, 2021
LIBRETRO_KRONOS_VERSION = a5ab56406cba23d1f2da06821518203275e567b1
LIBRETRO_KRONOS_SITE = $(call github,FCare,kronos,$(LIBRETRO_KRONOS_VERSION))
LIBRETRO_KRONOS_LICENSE = BSD-3-Clause

LIBRETRO_KRONOS_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_XU4),y)
LIBRETRO_KRONOS_PLATFORM = odroid
LIBRETRO_KRONOS_EXTRA_ARGS += BOARD=ODROID-XU4 FORCE_GLES=1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S922X),y)
LIBRETRO_KRONOS_PLATFORM = odroid-n2
LIBRETRO_KRONOS_EXTRA_ARGS += FORCE_GLES=1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RK3399)$(BR2_PACKAGE_BATOCERA_TARGET_RG552),y)
LIBRETRO_KRONOS_PLATFORM = rockpro64
LIBRETRO_KRONOS_EXTRA_ARGS += FORCE_GLES=1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S905GEN3),y)
LIBRETRO_KRONOS_PLATFORM = odroid-c4
LIBRETRO_KRONOS_EXTRA_ARGS += FORCE_GLES=1
endif

define LIBRETRO_KRONOS_BUILD_CMDS
	$(MAKE) -C $(@D)/yabause/src/libretro -f Makefile generate-files && \
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/yabause/src/libretro -f Makefile platform="$(LIBRETRO_KRONOS_PLATFORM)" $(LIBRETRO_KRONOS_EXTRA_ARGS)
endef

define LIBRETRO_KRONOS_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/yabause/src/libretro/kronos_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/kronos_libretro.so
endef

$(eval $(generic-package))
