# dir declaration
LIB_SECURESHIELD_DIR = $(EMBARC_ROOT)/library/secureshield

LIB_SECURESHIELD_ASMSRCDIR	= $(LIB_SECURESHIELD_DIR)/core/src \

LIB_SECURESHIELD_CSRCDIR	= $(LIB_SECURESHIELD_DIR)/core/src \

LIB_SECURESHIELD_INCDIR		= $(LIB_SECURESHIELD_DIR)/core/inc \

# interface files for application
APPL_CSRC_DIR += $(LIB_SECURESHIELD_DIR)/export/src
APPL_ASMSRC_DIR += $(LIB_SECURESHIELD_DIR)/export/src
APPL_INC_DIR += $(LIB_SECURESHIELD_DIR)/export/inc

include $(LIB_SECURESHIELD_DIR)/board/$(VALID_BOARD)/$(VALID_BOARD).mk

LIB_INCDIR += $(LIB_SECURESHIELD_INCDIR)
LIB_CSRCDIR += $(LIB_SECURESHIELD_CSRCDIR)
LIB_ASMSRCDIR += $(LIB_SECURESHIELD_ASMSRCDIR)

# the dir to generate objs
LIB_SECURESHIELD_OBJDIR = $(OUT_DIR)/library/secureshield

# find all the srcs in the target dirs
LIB_SECURESHIELD_CSRCS = $(call get_csrcs, $(LIB_SECURESHIELD_CSRCDIR))
LIB_SECURESHIELD_ASMSRCS = $(call get_asmsrcs, $(LIB_SECURESHIELD_ASMSRCDIR))

# get obj files
LIB_SECURESHIELD_COBJS = $(call get_objs, $(LIB_SECURESHIELD_CSRCS), $(LIB_SECURESHIELD_OBJDIR))
LIB_SECURESHIELD_ASMOBJS = $(call get_objs, $(LIB_SECURESHIELD_ASMSRCS), $(LIB_SECURESHIELD_OBJDIR))


# include dependency files
ifneq ($(MAKECMDGOALS),clean)
 -include $(LIB_SECURESHIELD_COBJS:.o=.o.d) $(LIB_SECURESHIELD_ASMOBJS:.o=.o.d)
endif

# generate library
LIB_LIB_SECURESHIELD = $(OUT_DIR)/libsecureshield.a
LIB_LIBS += $(LIB_LIB_SECURESHIELD)

$(LIB_LIB_SECURESHIELD): $(LIB_SECURESHIELD_OBJDIR) $(LIB_SECURESHIELD_COBJS) $(LIB_SECURESHIELD_ASMOBJS)
	$(TRACE_ARCHIVE)
	$(Q)$(AR) $(AR_OPT) $@ $(LIB_SECURESHIELD_COBJS) $(LIB_SECURESHIELD_ASMOBJS)

# for mwdt,  use -Ml option
ifeq ($(VAILD_TOOLCHAIN), mw)
ADT_COPT = -Ml
endif

# specific compile rules
.SECONDEXPANSION:
$(LIB_SECURESHIELD_COBJS): $(LIB_SECURESHIELD_OBJDIR)/%.o :$(call get_c_prerequisite, $(LIB_SECURESHIELD_CSRCDIR)) $$(COMMON_COMPILE_PREREQUISITES)
	$(TRACE_COMPILE)
	$(Q)$(CC) -c $(COMPILE_OPT) $(LIB_SECURESHIELD_COMPILE_OPT) $< -o $@

.SECONDEXPANSION:
$(LIB_SECURESHIELD_ASMOBJS): $(LIB_SECURESHIELD_OBJDIR)/%.o :$(call get_asm_prerequisite, $(LIB_SECURESHIELD_ASMSRCDIR)) $$(COMMON_COMPILE_PREREQUISITES)
	$(TRACE_ASSEMBLE)
	$(Q)$(CC) -c $(ASM_OPT) $(LIB_SECURESHIELD_COMPILE_OPT) $< -o $@

# generate obj dir
$(LIB_SECURESHIELD_OBJDIR):
	$(TRACE_CREATE_DIR)
	$(Q)$(MKD) $(subst /,$(PS),$@)

# Middleware Definitions
LIB_SECURESHIELD_DEFINES = -DLIB_SECURESHIELD
LIB_DEFINES += $(LIB_SECURESHIELD_DEFINES)
