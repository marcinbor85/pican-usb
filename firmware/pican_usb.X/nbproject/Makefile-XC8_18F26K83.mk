#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-XC8_18F26K83.mk)" "nbproject/Makefile-local-XC8_18F26K83.mk"
include nbproject/Makefile-local-XC8_18F26K83.mk
endif
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=XC8_18F26K83
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/pican_usb.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/pican_usb.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=--mafrlcsj
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=src/hal/tick.c src/hal/can.c src/hw/hw_tick.c src/hw/hw_leds.c src/hw/hw_ft245.c src/hw/hw_can.c src/net/ft245.c src/net/slcan.c src/tools/queuefifo.c src/tools/queue.c src/interrupts.c src/configuration_bits.c src/main.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/src/hal/tick.p1 ${OBJECTDIR}/src/hal/can.p1 ${OBJECTDIR}/src/hw/hw_tick.p1 ${OBJECTDIR}/src/hw/hw_leds.p1 ${OBJECTDIR}/src/hw/hw_ft245.p1 ${OBJECTDIR}/src/hw/hw_can.p1 ${OBJECTDIR}/src/net/ft245.p1 ${OBJECTDIR}/src/net/slcan.p1 ${OBJECTDIR}/src/tools/queuefifo.p1 ${OBJECTDIR}/src/tools/queue.p1 ${OBJECTDIR}/src/interrupts.p1 ${OBJECTDIR}/src/configuration_bits.p1 ${OBJECTDIR}/src/main.p1
POSSIBLE_DEPFILES=${OBJECTDIR}/src/hal/tick.p1.d ${OBJECTDIR}/src/hal/can.p1.d ${OBJECTDIR}/src/hw/hw_tick.p1.d ${OBJECTDIR}/src/hw/hw_leds.p1.d ${OBJECTDIR}/src/hw/hw_ft245.p1.d ${OBJECTDIR}/src/hw/hw_can.p1.d ${OBJECTDIR}/src/net/ft245.p1.d ${OBJECTDIR}/src/net/slcan.p1.d ${OBJECTDIR}/src/tools/queuefifo.p1.d ${OBJECTDIR}/src/tools/queue.p1.d ${OBJECTDIR}/src/interrupts.p1.d ${OBJECTDIR}/src/configuration_bits.p1.d ${OBJECTDIR}/src/main.p1.d

# Object Files
OBJECTFILES=${OBJECTDIR}/src/hal/tick.p1 ${OBJECTDIR}/src/hal/can.p1 ${OBJECTDIR}/src/hw/hw_tick.p1 ${OBJECTDIR}/src/hw/hw_leds.p1 ${OBJECTDIR}/src/hw/hw_ft245.p1 ${OBJECTDIR}/src/hw/hw_can.p1 ${OBJECTDIR}/src/net/ft245.p1 ${OBJECTDIR}/src/net/slcan.p1 ${OBJECTDIR}/src/tools/queuefifo.p1 ${OBJECTDIR}/src/tools/queue.p1 ${OBJECTDIR}/src/interrupts.p1 ${OBJECTDIR}/src/configuration_bits.p1 ${OBJECTDIR}/src/main.p1

# Source Files
SOURCEFILES=src/hal/tick.c src/hal/can.c src/hw/hw_tick.c src/hw/hw_leds.c src/hw/hw_ft245.c src/hw/hw_can.c src/net/ft245.c src/net/slcan.c src/tools/queuefifo.c src/tools/queue.c src/interrupts.c src/configuration_bits.c src/main.c


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-XC8_18F26K83.mk dist/${CND_CONF}/${IMAGE_TYPE}/pican_usb.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=18F26K83
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/hal/tick.p1: src/hal/tick.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hal" 
	@${RM} ${OBJECTDIR}/src/hal/tick.p1.d 
	@${RM} ${OBJECTDIR}/src/hal/tick.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hal/tick.p1  src/hal/tick.c 
	@-${MV} ${OBJECTDIR}/src/hal/tick.d ${OBJECTDIR}/src/hal/tick.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hal/tick.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/hal/can.p1: src/hal/can.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hal" 
	@${RM} ${OBJECTDIR}/src/hal/can.p1.d 
	@${RM} ${OBJECTDIR}/src/hal/can.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hal/can.p1  src/hal/can.c 
	@-${MV} ${OBJECTDIR}/src/hal/can.d ${OBJECTDIR}/src/hal/can.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hal/can.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/hw/hw_tick.p1: src/hw/hw_tick.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hw" 
	@${RM} ${OBJECTDIR}/src/hw/hw_tick.p1.d 
	@${RM} ${OBJECTDIR}/src/hw/hw_tick.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hw/hw_tick.p1  src/hw/hw_tick.c 
	@-${MV} ${OBJECTDIR}/src/hw/hw_tick.d ${OBJECTDIR}/src/hw/hw_tick.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hw/hw_tick.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/hw/hw_leds.p1: src/hw/hw_leds.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hw" 
	@${RM} ${OBJECTDIR}/src/hw/hw_leds.p1.d 
	@${RM} ${OBJECTDIR}/src/hw/hw_leds.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hw/hw_leds.p1  src/hw/hw_leds.c 
	@-${MV} ${OBJECTDIR}/src/hw/hw_leds.d ${OBJECTDIR}/src/hw/hw_leds.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hw/hw_leds.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/hw/hw_ft245.p1: src/hw/hw_ft245.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hw" 
	@${RM} ${OBJECTDIR}/src/hw/hw_ft245.p1.d 
	@${RM} ${OBJECTDIR}/src/hw/hw_ft245.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hw/hw_ft245.p1  src/hw/hw_ft245.c 
	@-${MV} ${OBJECTDIR}/src/hw/hw_ft245.d ${OBJECTDIR}/src/hw/hw_ft245.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hw/hw_ft245.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/hw/hw_can.p1: src/hw/hw_can.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hw" 
	@${RM} ${OBJECTDIR}/src/hw/hw_can.p1.d 
	@${RM} ${OBJECTDIR}/src/hw/hw_can.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hw/hw_can.p1  src/hw/hw_can.c 
	@-${MV} ${OBJECTDIR}/src/hw/hw_can.d ${OBJECTDIR}/src/hw/hw_can.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hw/hw_can.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/net/ft245.p1: src/net/ft245.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/net" 
	@${RM} ${OBJECTDIR}/src/net/ft245.p1.d 
	@${RM} ${OBJECTDIR}/src/net/ft245.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/net/ft245.p1  src/net/ft245.c 
	@-${MV} ${OBJECTDIR}/src/net/ft245.d ${OBJECTDIR}/src/net/ft245.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/net/ft245.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/net/slcan.p1: src/net/slcan.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/net" 
	@${RM} ${OBJECTDIR}/src/net/slcan.p1.d 
	@${RM} ${OBJECTDIR}/src/net/slcan.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/net/slcan.p1  src/net/slcan.c 
	@-${MV} ${OBJECTDIR}/src/net/slcan.d ${OBJECTDIR}/src/net/slcan.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/net/slcan.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/tools/queuefifo.p1: src/tools/queuefifo.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/tools" 
	@${RM} ${OBJECTDIR}/src/tools/queuefifo.p1.d 
	@${RM} ${OBJECTDIR}/src/tools/queuefifo.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/tools/queuefifo.p1  src/tools/queuefifo.c 
	@-${MV} ${OBJECTDIR}/src/tools/queuefifo.d ${OBJECTDIR}/src/tools/queuefifo.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/tools/queuefifo.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/tools/queue.p1: src/tools/queue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/tools" 
	@${RM} ${OBJECTDIR}/src/tools/queue.p1.d 
	@${RM} ${OBJECTDIR}/src/tools/queue.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/tools/queue.p1  src/tools/queue.c 
	@-${MV} ${OBJECTDIR}/src/tools/queue.d ${OBJECTDIR}/src/tools/queue.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/tools/queue.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/interrupts.p1: src/interrupts.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/interrupts.p1.d 
	@${RM} ${OBJECTDIR}/src/interrupts.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/interrupts.p1  src/interrupts.c 
	@-${MV} ${OBJECTDIR}/src/interrupts.d ${OBJECTDIR}/src/interrupts.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/interrupts.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/configuration_bits.p1: src/configuration_bits.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/configuration_bits.p1.d 
	@${RM} ${OBJECTDIR}/src/configuration_bits.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/configuration_bits.p1  src/configuration_bits.c 
	@-${MV} ${OBJECTDIR}/src/configuration_bits.d ${OBJECTDIR}/src/configuration_bits.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/configuration_bits.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/main.p1: src/main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/main.p1.d 
	@${RM} ${OBJECTDIR}/src/main.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/main.p1  src/main.c 
	@-${MV} ${OBJECTDIR}/src/main.d ${OBJECTDIR}/src/main.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/main.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
else
${OBJECTDIR}/src/hal/tick.p1: src/hal/tick.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hal" 
	@${RM} ${OBJECTDIR}/src/hal/tick.p1.d 
	@${RM} ${OBJECTDIR}/src/hal/tick.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hal/tick.p1  src/hal/tick.c 
	@-${MV} ${OBJECTDIR}/src/hal/tick.d ${OBJECTDIR}/src/hal/tick.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hal/tick.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/hal/can.p1: src/hal/can.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hal" 
	@${RM} ${OBJECTDIR}/src/hal/can.p1.d 
	@${RM} ${OBJECTDIR}/src/hal/can.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hal/can.p1  src/hal/can.c 
	@-${MV} ${OBJECTDIR}/src/hal/can.d ${OBJECTDIR}/src/hal/can.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hal/can.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/hw/hw_tick.p1: src/hw/hw_tick.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hw" 
	@${RM} ${OBJECTDIR}/src/hw/hw_tick.p1.d 
	@${RM} ${OBJECTDIR}/src/hw/hw_tick.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hw/hw_tick.p1  src/hw/hw_tick.c 
	@-${MV} ${OBJECTDIR}/src/hw/hw_tick.d ${OBJECTDIR}/src/hw/hw_tick.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hw/hw_tick.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/hw/hw_leds.p1: src/hw/hw_leds.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hw" 
	@${RM} ${OBJECTDIR}/src/hw/hw_leds.p1.d 
	@${RM} ${OBJECTDIR}/src/hw/hw_leds.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hw/hw_leds.p1  src/hw/hw_leds.c 
	@-${MV} ${OBJECTDIR}/src/hw/hw_leds.d ${OBJECTDIR}/src/hw/hw_leds.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hw/hw_leds.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/hw/hw_ft245.p1: src/hw/hw_ft245.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hw" 
	@${RM} ${OBJECTDIR}/src/hw/hw_ft245.p1.d 
	@${RM} ${OBJECTDIR}/src/hw/hw_ft245.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hw/hw_ft245.p1  src/hw/hw_ft245.c 
	@-${MV} ${OBJECTDIR}/src/hw/hw_ft245.d ${OBJECTDIR}/src/hw/hw_ft245.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hw/hw_ft245.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/hw/hw_can.p1: src/hw/hw_can.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/hw" 
	@${RM} ${OBJECTDIR}/src/hw/hw_can.p1.d 
	@${RM} ${OBJECTDIR}/src/hw/hw_can.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/hw/hw_can.p1  src/hw/hw_can.c 
	@-${MV} ${OBJECTDIR}/src/hw/hw_can.d ${OBJECTDIR}/src/hw/hw_can.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/hw/hw_can.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/net/ft245.p1: src/net/ft245.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/net" 
	@${RM} ${OBJECTDIR}/src/net/ft245.p1.d 
	@${RM} ${OBJECTDIR}/src/net/ft245.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/net/ft245.p1  src/net/ft245.c 
	@-${MV} ${OBJECTDIR}/src/net/ft245.d ${OBJECTDIR}/src/net/ft245.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/net/ft245.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/net/slcan.p1: src/net/slcan.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/net" 
	@${RM} ${OBJECTDIR}/src/net/slcan.p1.d 
	@${RM} ${OBJECTDIR}/src/net/slcan.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/net/slcan.p1  src/net/slcan.c 
	@-${MV} ${OBJECTDIR}/src/net/slcan.d ${OBJECTDIR}/src/net/slcan.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/net/slcan.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/tools/queuefifo.p1: src/tools/queuefifo.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/tools" 
	@${RM} ${OBJECTDIR}/src/tools/queuefifo.p1.d 
	@${RM} ${OBJECTDIR}/src/tools/queuefifo.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/tools/queuefifo.p1  src/tools/queuefifo.c 
	@-${MV} ${OBJECTDIR}/src/tools/queuefifo.d ${OBJECTDIR}/src/tools/queuefifo.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/tools/queuefifo.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/tools/queue.p1: src/tools/queue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src/tools" 
	@${RM} ${OBJECTDIR}/src/tools/queue.p1.d 
	@${RM} ${OBJECTDIR}/src/tools/queue.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/tools/queue.p1  src/tools/queue.c 
	@-${MV} ${OBJECTDIR}/src/tools/queue.d ${OBJECTDIR}/src/tools/queue.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/tools/queue.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/interrupts.p1: src/interrupts.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/interrupts.p1.d 
	@${RM} ${OBJECTDIR}/src/interrupts.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/interrupts.p1  src/interrupts.c 
	@-${MV} ${OBJECTDIR}/src/interrupts.d ${OBJECTDIR}/src/interrupts.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/interrupts.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/configuration_bits.p1: src/configuration_bits.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/configuration_bits.p1.d 
	@${RM} ${OBJECTDIR}/src/configuration_bits.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/configuration_bits.p1  src/configuration_bits.c 
	@-${MV} ${OBJECTDIR}/src/configuration_bits.d ${OBJECTDIR}/src/configuration_bits.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/configuration_bits.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/src/main.p1: src/main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/main.p1.d 
	@${RM} ${OBJECTDIR}/src/main.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/src/main.p1  src/main.c 
	@-${MV} ${OBJECTDIR}/src/main.d ${OBJECTDIR}/src/main.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/src/main.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/pican_usb.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE) --chip=$(MP_PROCESSOR_OPTION) -G -mdist/${CND_CONF}/${IMAGE_TYPE}/pican_usb.X.${IMAGE_TYPE}.map  -D__DEBUG=1 --debugger=pickit3  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"        $(COMPARISON_BUILD) --memorysummary dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml -odist/${CND_CONF}/${IMAGE_TYPE}/pican_usb.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	@${RM} dist/${CND_CONF}/${IMAGE_TYPE}/pican_usb.X.${IMAGE_TYPE}.hex 
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/pican_usb.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE) --chip=$(MP_PROCESSOR_OPTION) -G -mdist/${CND_CONF}/${IMAGE_TYPE}/pican_usb.X.${IMAGE_TYPE}.map  --double=24 --float=24 --emi=wordwrite --opt=+asm,+asmfile,+speed,-space,-debug,-local --addrqual=request --mode=pro -DNDEBUG -P -N255 -I"src" --warn=-3 --asmlist -DXPRJ_XC8_18F26K83=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"     $(COMPARISON_BUILD) --memorysummary dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml -odist/${CND_CONF}/${IMAGE_TYPE}/pican_usb.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/XC8_18F26K83
	${RM} -r dist/XC8_18F26K83

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
