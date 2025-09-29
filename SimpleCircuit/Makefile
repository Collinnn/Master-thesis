CDS_OPTS ?=
GUI ?= 0

ifeq ($(GUI),1)
	CDS_OPTS := -gui -access r
endif
SRCS = \
    SimpleToggleMachine.sv \
    SimpleToggleAssertion.sv \
    SimpleToggleHardwareAssertion.sv \
		top.sv

cds_test: $(SRCS)
	xrun $(CDS_OPTS) -sv $(SRCS) -top Top_tb
