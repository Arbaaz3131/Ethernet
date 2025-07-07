
`timescale	1ns/1ns
`include	"mcs_dv07_ethernet_assersions.sv"
//===============================================================================================================================================//
//----------------------------------------------------------------TOP----------------------------------------------------------------------------//
//===============================================================================================================================================//

module	ethernet_top;

	bit 	MRxCLK;
	bit 	MTxCLK;
	bit		pclk_i;
	import	ethernet_package::*;
	import	uvm_pkg::*;

	bit HUGEN,TxEN,PAD,NOPRE,SA,DA,FULLD;
	bit	[15:0]PAYLOAD_LENGTH;
	ethernet_config_class	h_ethernet_config_class;

	always #5 	pclk_i++;
	always #20	MTxCLK++;

	ethernet_interface	h_intf(pclk_i,MTxCLK);	


eth_top uut(
  // APB common
  .pclk_i(pclk_i), .prstn_i(h_intf.prstn_i), .pwdata_i(h_intf.pwdata_i), .prdata_o(h_intf.prdata_o), 

  // APB slave
  .paddr_i(h_intf.paddr_i), .psel_i(h_intf.psel_i), .pwrite_i(h_intf.pwrite_i), .penable_i(h_intf.penable_i), .pready_o(h_intf.pready_o), 

  // APB master
  .m_paddr_o(h_intf.m_paddr_o), .m_psel_o(h_intf.m_psel_o), .m_pwrite_o(h_intf.m_pwrite_o), 
  .m_pwdata_o(h_intf.m_pwdata_o), .m_prdata_i(h_intf.m_prdata_i), .m_penable_o(h_intf.m_penable_o), 
  .m_pready_i(h_intf.m_pready_i),  

  .int_o(h_intf.int_o),

  //TX
  .mtx_clk_pad_i(MTxCLK), .mtxd_pad_o(h_intf.MTxD), .mtxen_pad_o(h_intf.MTxEn), .mtxerr_pad_o(h_intf.MTxErr),

  //RX
  .mrx_clk_pad_i(MRxCLK), .mrxd_pad_i(h_intf.MRxD), .mrxdv_pad_i(h_intf.MRxDV), .mrxerr_pad_i(h_intf.MRxErr), .mcrs_pad_i(h_intf.MCrS) 
 
);


	eth_wishbone	regs(.r_TxEn(TxEN));
		
		assign TxEN=regs.r_TxEn;
				
	eth_txethmac	registers(.Pad(PAD),.No_Preamble(NOPRE),.MAC_Address(SA),.DA_Address(DA),.Payload_length(PAYLOAD_LENGTH),.FullD(FULLD),.HugEn(HUGEN));
		
		assign	PAD				=	registers.Pad;
		assign	NOPRE			=	registers.No_Preamble;
		assign	SA				=	registers.MAC_Address;
		assign	DA				=	registers.DA_Address;
		assign	PAYLOAD_LENGTH	=	registers.Payload_length;
		assign	FULLD			=	registers.FullD;
		assign	HUGEN			=	registers.HugEn;		

//------------------------------------------------ BINDING -------------------------------------------------//
/*
	bind uut assertion uut_assert(.pclk_i(pclk_i), .prstn_i(h_intf.prstn_i), .pwdata_i(h_intf.pwdata_i), .prdata_o(h_intf.prdata_o), 

  // APB slave
  .paddr_i(h_intf.paddr_i), .psel_i(h_intf.psel_i), .pwrite_i(h_intf.pwrite_i), .penable_i(h_intf.penable_i), .pready_o(h_intf.pready_o), 

  // APB master
  .m_paddr_o(h_intf.m_paddr_o), .m_psel_o(h_intf.m_psel_o), .m_pwrite_o(h_intf.m_pwrite_o), 
  .m_pwdata_o(h_intf.m_pwdata_o), .m_prdata_i(h_intf.m_prdata_i), .m_penable_o(h_intf.m_penable_o), 
  .m_pready_i(h_intf.m_pready_i),  

  .int_o(h_intf.int_o),

  //TX
  .MTxCLK(h_intf.MTxclk), .MTxD(h_intf.MTxD), .MTxEn(h_intf.MTxEn), .MTxErr(h_intf.MTxErr),

  //RX
  .MRxCLK(MRxCLK), .MRxD(h_intf.MRxD), .MRxDV(h_intf.MRxDV), .MRxErr(h_intf.MRxErr), .MCrS(h_intf.MCrS) ,.TxEn(TxEN) ,.PAD(PAD) , .NOPRE(NOPRE), .SA(SA), .DA(DA),.PAYLOAD_LENGTH(PAYLOAD_LENGTH),.FULLD(FULLD), .HUGEN(HUGEN));
	
*/

	initial begin
		
		h_ethernet_config_class=ethernet_config_class::type_id::create("h_ethernet_config_class");	

		uvm_config_db#(virtual ethernet_interface)::set(null,"*","h_intf",h_intf);

		uvm_config_db#(ethernet_config_class)::set(null,"*","h_ethernet_config_class",h_ethernet_config_class);

		run_test("ethernet_test");   

	end

endmodule




