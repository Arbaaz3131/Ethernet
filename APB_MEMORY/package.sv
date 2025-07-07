
package ethernet_package;

	import	uvm_pkg::*;

	`include "uvm_macros.svh"
typedef bit [3:0]nibble_type;
	
	`include	"../MCS_DV07_ETH_TOP/mcs_dv07_ethernet_config_class.sv"
	

	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_SEQUENCE/mcs_dv07_ethernet_sequence_item.sv"

	`include	"../MCS_DV07_ETH_SEQUENCE/MCS_DV07_ETH_TX_MAC_SEQUENCE/mcs_dv07_ethernet_tx_mac_sequence.sv"
	`include	"../MCS_DV07_ETH_SEQUENCE/MCS_DV07_ETH_MEM_SEQUENCE/mcs_dv07_ethernet_mem_sequence.sv"
	`include	"../MCS_DV07_ETH_SEQUENCE/MCS_DV07_ETH_HOST_SEQUENCE/mcs_dv07_ethernet_host_sequence.sv"

	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_HOST_AGENT/MCS_DV07_ETH_HOST_ACTIVE_AGENT/mcs_dv07_ethernet_host_sequencer.sv"
	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_HOST_AGENT/MCS_DV07_ETH_HOST_ACTIVE_AGENT/mcs_dv07_ethernet_host_driver.sv"
	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_HOST_AGENT/MCS_DV07_ETH_HOST_ACTIVE_AGENT/mcs_dv07_ethernet_host_monitor.sv"

	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_HOST_AGENT/MCS_DV07_ETH_HOST_ACTIVE_AGENT/mcs_dv07_ethernet_host_active_agent.sv"


	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_MEM_AGENT/MCS_DV07_ETH_MEM_ACTIVE_AGENT/mcs_dv07_ethernet_mem_sequencer.sv"
	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_MEM_AGENT/MCS_DV07_ETH_MEM_ACTIVE_AGENT/mcs_dv07_ethernet_mem_driver.sv"
	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_MEM_AGENT/MCS_DV07_ETH_MEM_ACTIVE_AGENT/mcs_dv07_ethernet_mem_input_monitor.sv"
	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_MEM_AGENT/MCS_DV07_ETH_MEM_ACTIVE_AGENT/mcs_dv07_ethernet_mem_active_agent.sv"


	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_TX_MAC_AGENT/MCS_DV07_ETH_TX_MAC_ACTIVE_AGENT/mcs_dv07_ethernet_tx_mac_sequencer.sv"

	`include	"../MCS_DV07_ETH_ENVIRONMENT/mcs_dv07_virtual_sequencer.sv"
	`include	"../MCS_DV07_ETH_ENVIRONMENT/mcs_dv07_virtual_sequence.sv"
	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_TX_MAC_AGENT/MCS_DV07_ETH_TX_MAC_ACTIVE_AGENT/mcs_dv07_ethernet_tx_mac_driver.sv"
	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_TX_MAC_AGENT/MCS_DV07_ETH_TX_MAC_ACTIVE_AGENT/mcs_dv07_ethernet_tx_mac_active_agent.sv"

	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_TX_MAC_AGENT/MCS_DV07_ETH_TX_MAC_PASSIVE_AGENT/mcs_dv07_ethernet_tx_mac_output_monitor.sv"
	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_AGENT/MCS_DV07_ETH_TX_MAC_AGENT/MCS_DV07_ETH_TX_MAC_PASSIVE_AGENT/mcs_dv07_ethernet_tx_mac_passive_agent.sv"

	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_ENVIRONMENT/MCS_DV07_ETH_HOST_ENVIRONMENT/mcs_dv07_ethernet_host_env.sv"
	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_ENVIRONMENT/MCS_DV07_ETH_MEM_ENVIRONMENT/mcs_dv07_ethernet_mem_env.sv"
	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_ENVIRONMENT/MCS_DV07_ETH_TX_MAC_ENVIRONMENT/mcs_dv07_ethernet_tx_mac_env.sv"
	`include	"../MCS_DV07_ETH_ENVIRONMENT/mcs_dv07_ethernet_coverages.sv"
	`include	"../MCS_DV07_ETH_ENVIRONMENT/mcs_dv07_ethernet_scoreboard.sv"

	`include	"/home/VLSI/missdv07/USERS/missdv0708/uvm/PROJECT/ethernet/TESTBENCH/MCS_DV07_ETH_ENVIRONMENT/mcs_dv07_ethernet_top_env.sv"
	
	`include	"mcs_dv07_ethernet_test.sv"

endpackage

//--------------------------------- design files --------------------------------//

    `include 	"../../RTL_DESIGN/apb_BDs_bridge.v"
    `include 	"../../RTL_DESIGN/eth_clockgen.v"
   `include 	"../../RTL_DESIGN/eth_crc.v"
   `include 	"../../RTL_DESIGN/eth_fifo.v"
   `include 	"../../RTL_DESIGN/eth_maccontrol.v"
   `include 	"../../RTL_DESIGN/ethmac_defines.v"
  `include 		"../../RTL_DESIGN/eth_macstatus.v"
   `include		"../../RTL_DESIGN/eth_miim.v"
  `include 		"../../RTL_DESIGN/eth_outputcontrol.v"
   `include 	"../../RTL_DESIGN/eth_random.v"
   `include 	"../../RTL_DESIGN/eth_receivecontrol.v"
   `include 	"../../RTL_DESIGN/eth_register.v"
   `include 	"../../RTL_DESIGN/eth_registers.v"
   `include 	"../../RTL_DESIGN/eth_rxaddrcheck.v"
   `include 	"../../RTL_DESIGN/eth_rxcounters.v"
  `include		"../../RTL_DESIGN/eth_rxethmac.v"
   `include 	"../../RTL_DESIGN/eth_rxstatem.v"
   `include "../../RTL_DESIGN/eth_shiftreg.v"
   `include "../../RTL_DESIGN/eth_spram_256x32.v"
   `include "../../RTL_DESIGN/eth_top.v"
  `include "../../RTL_DESIGN/eth_transmitcontrol.v"
  `include "../../RTL_DESIGN/eth_txcounters.v"
   `include "../../RTL_DESIGN/eth_txethmac.v"
   `include "../../RTL_DESIGN/eth_txstatem.v"
   `include "../../RTL_DESIGN/eth_wishbone.v"




