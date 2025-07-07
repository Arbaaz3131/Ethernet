home = /home/chicago/tools/Questa_2021.4_3/questasim/linux_x86_64/../modelsim.ini

pack = /home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_TEST/package.sv
interface = ../MCS_DV07_ETH_INTERFACE/mcs_dv07_ethernet_interface.sv
dut	 = ../../RTL_DESIGN/eth_ethernet_top.v
#interface = ethernet_topology_interface.sv
ethernet_top	=	../MCS_DV07_ETH_TOP/mcs_dv07_ethernet_top.sv
work:
	vlib work
map:
	vmap work work 

comp:
	vlog -work work +cover +acc -sv $(pack) $(interface) $(ethernet_top) 

sim:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit final.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l final.log -wlf final.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH 
	vsim -view final.wlf &


sim_reset_low:
	vlog -work work +cover +acc -sv $(pack) $(interface) $(ethernet_top) +define+reset_low
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit reset_low.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l reset_low.log -wlf reset_low.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,reset_low
	vsim -view reset_low.wlf &

sim_reset_read:
	vlog -work work +cover +acc -sv $(pack) $(interface) $(ethernet_top) +define+reset_low +define+reset_read
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit reset_read.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l reset_read.log -wlf reset_read.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,reset_read
	vsim -view reset_read.wlf &


sim_write_read:
	vlog -work work +cover +acc -sv $(pack) $(interface) $(ethernet_top) +define+reset_low +define+write_read
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit write_read.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l write_read.log -wlf write_read.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,write_read
	vsim -view write_read.wlf &

sim_struck_at0:
	vlog -work work +cover +acc -sv $(pack) $(interface) $(ethernet_top) +define+reset_low +define+struck_at0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit struck_at0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l struck_at0.log -wlf struck_at0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,struck_at0
	vsim -view struck_at0.wlf &

sim_struck_at1:		
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit struck_at1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l struck_at1.log -wlf struck_at1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,struck_at1
	vsim -view struck_at1.wlf &

sim_half_duplex:
	vlog -work work +cover +acc -sv $(pack) $(interface) $(ethernet_top) +define+reset_low +define+half_duplex	
	vsim  -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit half_duplex.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l half_duplex.log -wlf half_duplex.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,half_duplex
	vsim -view half_duplex.wlf &

sim_full_duplex:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit full_duplex.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l full_duplex.log -wlf full_duplex.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,full_duplex
	vsim -view full_duplex.wlf &



sim_rxen_1:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rxen_1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rxen_1.log -wlf rxen_1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rxen_1
	vsim -view rxen_1.wlf &



sim_txen1_rxen1_fulld0:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit txen1_rxen1_fulld0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l txen1_rxen1_fulld0.log -wlf txen1_rxen1_fulld0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,txen1_rxen1_fulld0
	vsim -view txen1_rxen1_fulld0.wlf &

sim_txen1_rxen1_fulld1:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit txen1_rxen1_fulld1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l txen1_rxen1_fulld1.log -wlf txen1_rxen1_fulld1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,txen1_rxen1_fulld1
	vsim -view txen1_rxen1_fulld1.wlf &


sim_txen_0:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit txen_1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l txen_0.log -wlf txen_0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,txen_0
	vsim -view txen_0.wlf &

sim_all_bd_rd0:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd0.log -wlf all_bd_rd0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd0
	vsim -view all_bd_rd0.wlf &

sim_all_bd_rd1:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd1.log -wlf all_bd_rd1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd1
	vsim -view all_bd_rd1.wlf &

sim_config_all:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit config_all.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l config_all.log -wlf config_all.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,config_all
	vsim -view config_all.wlf &


sim_all_bd_rd_1010:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd_1010.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd_1010.log -wlf all_bd_rd_1010.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd_1010
	vsim -view all_bd_rd_1010.wlf &

sim_all_bd_rd_0101:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd_0101.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd_0101.log -wlf all_bd_rd_0101.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd_0101
	vsim -view all_bd_rd_0101.wlf &


sim_tx_bd_num0:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit tx_bd_num0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l tx_bd_num0.log -wlf tx_bd_num0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,tx_bd_num0
	vsim -view tx_bd_num0.wlf &


sim_rd0_rd1:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rd0_rd1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rd0_rd1.log -wlf rd0_rd1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rd0_rd1
	vsim -view rd0_rd1.wlf &


sim_rd0:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rd0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rd0.log -wlf rd0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rd0
	vsim -view rd0.wlf &

sim_sudden_reset:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit sudden_reset.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l sudden_reset.log -wlf sudden_reset.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=mem_driver,sudden_reset
	vsim -view sudden_reset.wlf &


sim_mcrs_0:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit mcrs_0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l mcrs_0.log -wlf mcrs_0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=tx_mac_driver,mcrs_0
	vsim -view mcrs_0.wlf &


sim_len_g46_condition_irq1: 
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g46_condition_irq1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g46_condition_irq1.log -wlf len_g46_condition_irq1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g46_condition_irq1
	vsim -view len_g46_condition_irq1.wlf &


sim_len_g46_condition_irq0: 
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g46_condition_irq0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g46_condition_irq0.log -wlf len_g46_condition_irq0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g46_condition_irq0
	vsim -view len_g46_condition_irq0.wlf &


sim_len_g46_irq1_with_masking : 
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g46_irq1_with_masking.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g46_irq1_with_masking.log -wlf len_g46_irq1_with_masking.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g46_irq1_with_masking
	vsim -view len_g46_irq1_with_masking.wlf &



sim_len_g1500_irq1_with_hugen0 :
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g1500_irq1_with_hugen0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g1500_irq1_with_hugen0.log -wlf len_g1500_irq1_with_hugen0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g1500_irq1_with_hugen0
	vsim -view len_g1500_irq1_with_hugen0.wlf &

sim_len_g1500_irq0_with_hugen0: 
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g1500_irq0_with_hugen0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g1500_irq0_with_hugen0.log -wlf len_g1500_irq0_with_hugen0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g1500_irq0_with_hugen0
	vsim -view len_g1500_irq0_with_hugen0.wlf &


sim_len_g1500_irq1_with_hugen0_masking :
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g1500_irq1_with_hugen0_masking.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g1500_irq1_with_hugen0_masking.log -wlf .wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g1500_irq1_with_hugen0_masking
	vsim -view len_g1500_irq1_with_hugen0_masking.wlf &

sim_len_g1500_irq1_with_hugen1 : 
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g1500_irq1_with_hugen1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g1500_irq1_with_hugen1.log -wlf len_g1500_irq1_with_hugen1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g1500_irq1_with_hugen1
	vsim -view len_g1500_irq1_with_hugen1.wlf &

sim_len_g1500_irq0_with_hugen1:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g1500_irq0_with_hugen1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g1500_irq0_with_hugen1.log -wlf len_g1500_irq0_with_hugen1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g1500_irq0_with_hugen1
	vsim -view len_g1500_irq0_with_hugen1.wlf &






sim_len_g4_irq1_with_pad1: 
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq1_with_pad1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g4_irq1_with_pad1.log -wlf len_g4_irq1_with_pad1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq1_with_pad1
	vsim -view len_g4_irq1_with_pad1.wlf &


sim_len_g4_irq1_with_pad1_txb_mask:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq1_with_pad1_txb_mask.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g4_irq1_with_pad1_txb_mask.log -wlf len_g4_irq1_with_pad1_txb_mask.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq1_with_pad1_txb_mask
	vsim -view len_g4_irq1_with_pad1_txb_mask.wlf &

sim_len_g4_irq1_with_pad1_txe_mask:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq1_with_pad1_txe_mask.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l test.log -wlf len_g4_irq1_with_pad1_txe_mask.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq1_with_pad1_txe_mask
	vsim -view len_g4_irq1_with_pad1_txe_mask.wlf &

sim_len_g4_irq1_with_pad1_with_mask:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq1_with_pad1_with_mask.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g4_irq1_with_pad1_with_mask.log -wlf len_g4_irq1_with_pad1_with_mask.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq1_with_pad1_with_mask
	vsim -view len_g4_irq1_with_pad1_with_mask.wlf &


sim_len_g4_irq0_with_pad1:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq0_with_pad1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g4_irq0_with_pad1.log -wlf len_g4_irq0_with_pad1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq0_with_pad1
	vsim -view len_g4_irq0_with_pad1.wlf &


sim_len_g4_irq1_with_pad0:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq1_with_pad0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g4_irq1_with_pad0.log -wlf len_g4_irq1_with_pad0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq1_with_pad0
	vsim -view len_g4_irq1_with_pad0.wlf &


sim_nopre_low_irq_high:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit nopre_low_irq_high.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l nopre_low_irq_high.log -wlf nopre_low_irq_high.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,nopre_low_irq_high
	vsim -view nopre_low_irq_high.wlf &

sim_nopre_high_irq_mask:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit sim_nopre_high_irq_mask.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l sim_nopre_high_irq_mask.log -wlf sim_nopre_high_irq_mask.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,nopre_high_irq_mask
	vsim -view sim_nopre_high_irq_mask.wlf &

#-----------func error cases---------------------------------------
sim_len_g_2030_with_irq :
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g_2030_with_irq.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g_2030_with_irq.log -wlf len_g_2030_with_irq.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g_2030_with_irq
	vsim -view len_g_2030_with_irq.wlf &

sim_len_g_2030_with_irq_txb_mask:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g_2030_with_irq_txb_mask.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g_2030_with_irq_txb_mask.log -wlf len_g_2030_with_irq_txb_mask.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g_2030_with_irq_txb_mask
	vsim -view len_g_2030_with_irq_txb_mask.wlf &


sim_len_g_2030_with_irq_txe_masked:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g_2030_with_irq_txe_masked.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g_2030_with_irq_txe_masked.log -wlf len_g_2030_with_irq_txe_masked.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g_2030_with_irq_txe_masked
	vsim -view len_g_2030_with_irq_txe_masked.wlf &

sim_len_46_pad0_corner:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_46_pad0_corner.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_46_pad0_corner.log -wlf len_46_pad0_corner.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_46_pad0_corner
	vsim -view len_46_pad0_corner.wlf &

sim_len_46_pad1_corner:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_46_pad1_corner.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_46_pad1_corner.log -wlf len_46_pad1_corner.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_46_pad1_corner
	vsim -view len_46_pad1_corner.wlf &

sim_len_1500_hugen0_corner:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_1500_hugen0_corner.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_1500_hugen0_corner.log -wlf len_1500_hugen0_corner.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_1500_hugen0_corner
	vsim -view len_1500_hugen0_corner.wlf &


sim_len_1500_hugen1_corner:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_1500_hugen1_corner.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_1500_hugen1_corner.log -wlf len_1500_hugen1_corner.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_1500_hugen1_corner
	vsim -view len_1500_hugen1_corner.wlf &


sim_len5:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len5.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len5.log -wlf len5.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len5
	vsim -view len5.wlf &
	
sim_len4:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len4.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len4.log -wlf len4.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len4
	vsim -view len4.wlf &



sim_len_l4_irq1:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_irq1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_irq1.log -wlf len_l4_irq1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_irq1
	vsim -view len_l4_irq1.wlf &


sim_len_g_2030_with_irq_txe_txb_masked:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g_2030_with_irq_txe_txb_masked.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g_2030_with_irq_txe_txb_masked.log -wlf len_g_2030_with_irq_txe_txb_masked.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g_2030_with_irq_txe_txb_masked
	vsim -view len_g_2030_with_irq_txe_txb_masked.wlf &



sim_len_g_1500_with_irq_mask_hugen_high:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g_1500_with_irq_mask_hugen_high.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g_1500_with_irq_mask_hugen_high.log -wlf len_g_1500_with_irq_mask_hugen_high.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g_1500_with_irq_mask_hugen_high
	vsim -view len_g_1500_with_irq_mask_hugen_high.wlf &
	
sim_MTxERR_CHECK:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit MTxERR_CHECK.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l MTxERR_CHECK.log -wlf MTxERR_CHECK.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,MTxERR_CHECK  +uvm_set_type_override=mem_driver,mem_driver_mtxerr
	vsim -view MTxERR_CHECK.wlf &


sim_len_l_4_irq_no_masking:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l_4_irq_no_masking.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l_4_irq_no_masking.log -wlf len_l_4_irq_no_masking.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l_4_irq_no_masking 
	vsim -view len_l_4_irq_no_masking.wlf &
	



#================================================ FUNC ERROR CONDITIONS

sim_len_l4_rq1:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_rq1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_rq1.log -wlf len_l4_rq1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_rq1
	vsim -view len_l4_rq1.wlf &

sim_len_l4_irq1_txbm0:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_irq1_txbm0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_irq1_txbm0.log -wlf len_l4_irq1_txbm0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_irq1_txbm0
	vsim -view len_l4_irq1_txbm0.wlf &

sim_len_l4_irq1_txem0:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_irq1_txem0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_irq1_txem0.log -wlf len_l4_irq1_txem0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_irq1_txem0
	vsim -view len_l4_irq1_txem0.wlf &

sim_len_l4_irq1_txem0_txbm0:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_irq1_txem0_txbm0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_irq1_txem0_txbm0.log -wlf len_l4_irq1_txem0_txbm0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_irq1_txem0_txbm0
	vsim -view len_l4_irq1_txem0_txbm0.wlf &



sim_len_l4_irq0:
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_irq0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_irq0.log -wlf len_l4_irq0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_irq0
	vsim -view len_l4_irq0.wlf &


#================================================================  REGRESSION  ===================================================#

	
reggression:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit reset_low.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l reset_low.log -wlf reset_low.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,reset_low
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit reset_read.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l reset_read.log -wlf reset_read.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,reset_read
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g46_condition_irq1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g46_condition_irq1.log -wlf len_g46_condition_irq1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g46_condition_irq1
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g46_condition_irq0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g46_condition_irq0.log -wlf len_g46_condition_irq0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g46_condition_irq0
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g46_irq1_with_masking.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g46_irq1_with_masking.log -wlf len_g46_irq1_with_masking.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g46_irq1_with_masking
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g1500_irq1_with_hugen0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g1500_irq1_with_hugen0.log -wlf len_g1500_irq1_with_hugen0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g1500_irq1_with_hugen0
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g1500_irq0_with_hugen0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g1500_irq0_with_hugen0.log -wlf len_g1500_irq0_with_hugen0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g1500_irq0_with_hugen0
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g1500_irq1_with_hugen0_masking.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g1500_irq1_with_hugen0_masking.log -wlf .wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g1500_irq1_with_hugen0_masking
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g1500_irq1_with_hugen1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g1500_irq1_with_hugen1.log -wlf len_g1500_irq1_with_hugen1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g1500_irq1_with_hugen1
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g1500_irq0_with_hugen1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g1500_irq0_with_hugen1.log -wlf len_g1500_irq0_with_hugen1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g1500_irq0_with_hugen1
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq1_with_pad1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g4_irq1_with_pad1.log -wlf len_g4_irq1_with_pad1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq1_with_pad1
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq1_with_pad1_txb_mask.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g4_irq1_with_pad1_txb_mask.log -wlf len_g4_irq1_with_pad1_txb_mask.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq1_with_pad1_txb_mask
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq1_with_pad1_txe_mask.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l test.log -wlf len_g4_irq1_with_pad1_txe_mask.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq1_with_pad1_txe_mask
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq1_with_pad1_with_mask.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g4_irq1_with_pad1_with_mask.log -wlf len_g4_irq1_with_pad1_with_mask.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq1_with_pad1_with_mask
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq0_with_pad1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g4_irq0_with_pad1.log -wlf len_g4_irq0_with_pad1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq0_with_pad1
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g4_irq1_with_pad0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g4_irq1_with_pad0.log -wlf len_g4_irq1_with_pad0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g4_irq1_with_pad0
	vsim -view len_g4_irq1_with_pad0.wlf &
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit nopre_low_irq_high.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l nopre_low_irq_high.log -wlf nopre_low_irq_high.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,nopre_low_irq_high
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit sim_nopre_high_irq_mask.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l sim_nopre_high_irq_mask.log -wlf sim_nopre_high_irq_mask.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,nopre_high_irq_mask
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g_2030_with_irq.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g_2030_with_irq.log -wlf len_g_2030_with_irq.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g_2030_with_irq
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g_2030_with_irq_txb_mask.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g_2030_with_irq_txb_mask.log -wlf len_g_2030_with_irq_txb_mask.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g_2030_with_irq_txb_mask
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g_2030_with_irq_txe_masked.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g_2030_with_irq_txe_masked.log -wlf len_g_2030_with_irq_txe_masked.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g_2030_with_irq_txe_masked
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_irq1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_irq1.log -wlf len_l4_irq1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_irq1
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g_2030_with_irq_txe_txb_masked.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g_2030_with_irq_txe_txb_masked.log -wlf len_g_2030_with_irq_txe_txb_masked.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g_2030_with_irq_txe_txb_masked
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_irq1_txem0_txbm0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_irq1_txem0_txbm0.log -wlf len_l4_irq1_txem0_txbm0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_irq1_txem0_txbm0
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_irq0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_irq0.log -wlf len_l4_irq0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_irq0
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_g_1500_with_irq_mask_hugen_high.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_g_1500_with_irq_mask_hugen_high.log -wlf len_g_1500_with_irq_mask_hugen_high.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_g_1500_with_irq_mask_hugen_high
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit MTxERR_CHECK.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l MTxERR_CHECK.log -wlf MTxERR_CHECK.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,MTxERR_CHECK  +uvm_set_type_override=mem_driver,mem_driver_mtxerr
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l_4_irq_no_masking.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l_4_irq_no_masking.log -wlf len_l_4_irq_no_masking.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l_4_irq_no_masking 
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_rq1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_rq1.log -wlf len_l4_rq1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_rq1
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_irq1_txbm0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_irq1_txbm0.log -wlf len_l4_irq1_txbm0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_irq1_txbm0
	vsim -coverage -debugdb -sva -c -do "log -r /*;coverage save -onexit len_l4_irq1_txem0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l len_l4_irq1_txem0.log -wlf len_l4_irq1_txem0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,len_l4_irq1_txem0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit write_read.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l write_read.log -wlf write_read.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,write_read
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit struck_at0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l struck_at0.log -wlf struck_at0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,struck_at0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit full_duplex.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l full_duplex.log -wlf full_duplex.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,full_duplex
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit half_duplex.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l half_duplex.log -wlf half_duplex.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,half_duplex
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rxen_1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rxen_1.log -wlf rxen_1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rxen_1
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit txen1_rxen1_fulld0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l txen1_rxen1_fulld0.log -wlf txen1_rxen1_fulld0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,txen1_rxen1_fulld0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit txen1_rxen1_fulld1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l txen1_rxen1_fulld1.log -wlf txen1_rxen1_fulld1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,txen1_rxen1_fulld1
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit txen_0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l txen_0.log -wlf txen_0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,txen_0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd0.log -wlf all_bd_rd0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd1.log -wlf all_bd_rd1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd1
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit config_all.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l config_all.log -wlf config_all.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,config_all
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd_1010.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd_1010.log -wlf all_bd_rd_1010.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd_1010
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd_0101.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd_0101.log -wlf all_bd_rd_0101.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd_0101
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit tx_bd_num0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l tx_bd_num0.log -wlf tx_bd_num0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,tx_bd_num0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rd0_rd1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rd0_rd1.log -wlf rd0_rd1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rd0_rd1
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rd0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rd0.log -wlf rd0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rd0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit sudden_reset.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l sudden_reset.log -wlf sudden_reset.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=sim_all_bd_rd1,sudden_reset
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit mcrs_0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l mcrs_0.log -wlf mcrs_0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=tx_mac_driver,mcrs_0
	vsim -view mcrs_0.wlf &
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit cover_file.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l test.log work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_DEBUG
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit reset_low.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l reset_low.log -wlf reset_low.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,reset_low
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit reset_read.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l reset_read.log -wlf reset_read.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,reset_read
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit write_read.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l write_read.log -wlf write_read.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,write_read
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit struck_at0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l struck_at0.log -wlf struck_at0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,struck_at0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit full_duplex.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l full_duplex.log -wlf full_duplex.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,full_duplex
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit half_duplex.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l half_duplex.log -wlf half_duplex.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,half_duplex
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rxen_1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rxen_1.log -wlf rxen_1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rxen_1
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit txen1_rxen1_fulld0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l txen1_rxen1_fulld0.log -wlf txen1_rxen1_fulld0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,txen1_rxen1_fulld0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit txen_0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l txen_0.log -wlf txen_0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,txen_0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd0.log -wlf all_bd_rd0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd1.log -wlf all_bd_rd1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd1
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit config_all.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l config_all.log -wlf config_all.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,config_all
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd_1010.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd_1010.log -wlf all_bd_rd_1010.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd_1010
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd_0101.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd_0101.log -wlf all_bd_rd_0101.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd_0101
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit tx_bd_num0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l tx_bd_num0.log -wlf tx_bd_num0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,tx_bd_num0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rd0_rd1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rd0_rd1.log -wlf rd0_rd1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rd0_rd1
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rd0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rd0.log -wlf rd0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rd0
	vsim -view rd0.wlf &

	
wave: 
	vsim -view vsim.wlf &

merge:
	vcover merge all_cover.ucdb *.ucdb
	
clean:
	rm -rf *.ini transcript work regression_status_list *.log merge_list_file *.wlf .goutputstream* *.swp *.dbg wlf* *.vstf *.ucdb



sanity:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit cover_file.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l test.log work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_DEBUG
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit reset_low.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l reset_low.log -wlf reset_low.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,reset_low
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit reset_read.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l reset_read.log -wlf reset_read.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,reset_read
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit write_read.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l write_read.log -wlf write_read.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,write_read
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit struck_at0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l struck_at0.log -wlf struck_at0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,struck_at0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit full_duplex.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l full_duplex.log -wlf full_duplex.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,full_duplex
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit half_duplex.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l half_duplex.log -wlf half_duplex.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,half_duplex
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rxen_1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rxen_1.log -wlf rxen_1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rxen_1
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit txen1_rxen1_fulld0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l txen1_rxen1_fulld0.log -wlf txen1_rxen1_fulld0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,txen1_rxen1_fulld0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit txen_0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l txen_0.log -wlf txen_0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,txen_0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd0.log -wlf all_bd_rd0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd1.log -wlf all_bd_rd1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd1
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit config_all.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l config_all.log -wlf config_all.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,config_all
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd_1010.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd_1010.log -wlf all_bd_rd_1010.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd_1010
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit all_bd_rd_0101.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l all_bd_rd_0101.log -wlf all_bd_rd_0101.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,all_bd_rd_0101
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit tx_bd_num0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l tx_bd_num0.log -wlf tx_bd_num0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,tx_bd_num0
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rd0_rd1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rd0_rd1.log -wlf rd0_rd1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rd0_rd1
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit rd0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l rd0.log -wlf rd0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,rd0
	vsim -view rd0.wlf &


sim_all:
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit reset_low.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l reset_low.log -wlf reset_low.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,reset_low
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit reset_read.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l reset_read.log -wlf reset_read.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,reset_read
	vsim -view reset_read.wlf &
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit write_read.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l write_read.log -wlf write_read.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,write_read
	vsim -view write_read.wlf &
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit struck_at0.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l struck_at0.log -wlf struck_at0.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,struck_at0
	vsim -view struck_at0.wlf &
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit struck_at1.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l struck_at1.log -wlf struck_at1.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,struck_at1
	vsim -view struck_at1.wlf &
	vsim  -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit half_duplex.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l half_duplex.log -wlf half_duplex.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,half_duplex
	vsim -view half_duplex.wlf &
	vsim -debugdb -coverage -sva -c -do "log -r /*;coverage save -onexit full_duplex.ucdb -assert -directive -cvg -codeAll ;run -all ;exit" -coverage -sva -l full_duplex.log -wlf full_duplex.wlf work.ethernet_top +UVM_TESTNAME=ethernet_test +svSeed=RANDOM +UVM_VERBOSITY=UVM_HIGH +uvm_set_type_override=host_sequence,full_duplex
	vsim -view full_duplex.wlf &

