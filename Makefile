# Static or shared libraries should be built (STATIC or SHARED)?
LibType := SHARED

# Select optimization (-O or -g). -O will be automatically bumped up to the 
# highest level of optimization the compiler supports. If want something in
# between then specify the exact level you want, e.g., -O1 or -O2
#OptLevel := -O2
OptLevel := -g

ifeq ($(OptLevel),-g)
    CXXFLAGS += -DCLP_DEBUG
endif

LIBNAME := Clp
LIBSRC :=
LIBSRC += ClpDualRowDantzig.cpp
LIBSRC += ClpDualRowPivot.cpp
LIBSRC += ClpDualRowSteepest.cpp
LIBSRC += ClpFactorization.cpp
#LIBSRC += ClpMalloc.cpp
LIBSRC += ClpMatrixBase.cpp
LIBSRC += ClpMessage.cpp
LIBSRC += ClpModel.cpp
LIBSRC += ClpNonLinearCost.cpp
LIBSRC += ClpPackedMatrix.cpp
LIBSRC += ClpPrimalColumnDantzig.cpp
LIBSRC += ClpPrimalColumnPivot.cpp
LIBSRC += ClpPrimalColumnSteepest.cpp
LIBSRC += ClpSimplex.cpp
LIBSRC += ClpSimplexDual.cpp
LIBSRC += ClpSimplexPrimal.cpp

export CoinDir = $(shell cd ..; pwd)
##############################################################################
# You should not need to edit below this line.
##############################################################################
# The location of the customized Makefiles
export CoinDir = $(shell cd ..; pwd)
export MakefileDir := $(CoinDir)/Makefiles
include ${MakefileDir}/Makefile.coin
include ${MakefileDir}/Makefile.location

export ExtraIncDir  := ${CoinIncDir} ${zlibIncDir} ${bzlibIncDir}
export ExtraLibDir  := ${CoinLibDir} ${zlibLibDir} ${bzlibLibDir}
export ExtraLibName := ${CoinLibName} ${zlibLibName} ${bzlibLibName}
export ExtraDefine  := ${CoinDefine} ${zlibDefine} ${bzlibDefine}

export LibType OptLevel LIBNAME LIBSRC

###############################################################################

.DELETE_ON_ERROR:

.PHONY: default install libClp library clean doc

default: install

unitTest : install
	(cd Test && ${MAKE} unitTest)

install clean doc: % :
	$(MAKE) -f ${MakefileDir}/Makefile.lib $*

libClp:
	(cd $(CoinDir)/Coin && $(MAKE))
	$(MAKE) -f ${MakefileDir}/Makefile.lib library
