# dir declaration
MID_WOLFSSL_DIR = $(EMBARC_ROOT)/middleware/wolfssl

MID_WOLFSSL_ASMSRCDIR	=
MID_WOLFSSL_CSRCDIR	= $(MID_WOLFSSL_DIR)/src $(MID_WOLFSSL_DIR)/wolfcrypt/src
MID_WOLFSSL_INCDIR	= $(MID_WOLFSSL_DIR)

MID_INCDIR += $(MID_WOLFSSL_INCDIR)
MID_CSRCDIR += $(MID_WOLFSSL_CSRCDIR)
MID_ASMSRCDIR += $(MID_WOLFSSL_ASMSRCDIR)

# the dir to generate objs
MID_WOLFSSL_OBJDIR = $(OUT_DIR)/middleware/wolfssl

# find all the srcs in the target dirs
MID_WOLFSSL_CSRCS = $(call get_csrcs, $(MID_WOLFSSL_CSRCDIR))
MID_WOLFSSL_ASMSRCS = $(call get_asmsrcs, $(MID_WOLFSSL_ASMSRCDIR))

MID_WOLFSSL_COBJS = $(call get_objs, $(MID_WOLFSSL_CSRCS), $(MID_WOLFSSL_OBJDIR))
MID_WOLFSSL_ASMOBJS = $(call get_objs, $(MID_WOLFSSL_ASMSRCS), $(MID_WOLFSSL_OBJDIR))

# include dependency files
ifneq ($(MAKECMDGOALS),clean)
 -include $(MID_WOLFSSL_COBJS:.o=.o.d) $(MID_WOLFSSL_ASMOBJS:.o=.o.d)
endif

# genearte library
MID_LIB_WOLFSSL = $(OUT_DIR)/libmidwolfssl.a
MID_LIBS += $(MID_LIB_WOLFSSL)

$(MID_LIB_WOLFSSL): $(MID_WOLFSSL_OBJDIR) $(MID_WOLFSSL_COBJS) $(MID_WOLFSSL_ASMOBJS)
	$(TRACE_ARCHIVE)
	$(Q)$(AR) $(AR_OPT) $@ $(MID_WOLFSSL_COBJS) $(MID_WOLFSSL_ASMOBJS)

# specific compile rules
.SECONDEXPANSION:
$(MID_WOLFSSL_COBJS): $(MID_WOLFSSL_OBJDIR)/%.o :$(call get_c_prerequisite, $(MID_WOLFSSL_CSRCDIR)) $$(COMMON_COMPILE_PREREQUISITES)
	$(TRACE_COMPILE)
	$(Q)$(CC) -c $(COMPILE_OPT) $(MID_WOLFSSL_COMPILE_OPT) $< -o $@

.SECONDEXPANSION:
$(MID_WOLFSSL_ASMOBJS): $(MID_WOLFSSL_OBJDIR)/%.o :$(call get_asm_prerequisite, $(MID_WOLFSSL_ASMSRCDIR)) $$(COMMON_COMPILE_PREREQUISITES)
	$(TRACE_ASSEMBLE)
	$(Q)$(CC) -c $(ASM_OPT) $(MID_WOLFSSL_COMPILE_OPT) $< -o $@

# generate obj dir
$(MID_WOLFSSL_OBJDIR):
	$(TRACE_CREATE_DIR)
	$(Q)$(MKD) $(subst /,$(PS),$@)

# Middleware Definitions
MID_WOLFSSL_DEFINES = -DMID_WOLFSSL
MID_DEFINES += $(MID_WOLFSSL_DEFINES)

