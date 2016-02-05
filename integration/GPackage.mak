
INTEGRATION_VODE_PATH := $(MICROPHYSICS_DIR)/integration/VODE

FINCLUDE_LOCATIONS    += $(INTEGRATION_VODE_PATH)
VPATH_LOCATIONS       += $(INTEGRATION_VODE_PATH)
EXTERN_PARAMETER_DIRS += $(INTEGRATION_VODE_PATH)

include $(INTEGRATION_VODE_PATH)/GPackage.mak



f90sources += integration.f90
f90sources += integration_data.f90
f90sources += temperature_integration.f90
