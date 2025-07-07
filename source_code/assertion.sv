module assertion(input pclk_i, prstn_i, input [31:0]pwdata_i, prdata_o, 

  // APB slave
  paddr_i, input psel_i,pwrite_i, penable_i, pready_o, 

  // APB master
  input [31:0]m_paddr_o, input m_psel_o, m_pwrite_o, 
  input	[31:0]m_pwdata_o, m_prdata_i, input m_penable_o,  m_pready_i, int_o,

  //TX
  input  MTxCLK, input [3:0] MTxD,input MTxEn, MTxErr,

  //RX
  input  MRxCLK, input [3:0]MRxD, input MRxDV , MRxErr, MCrS  ,TxEn	,PAD, NOPRE,SA,DA,input [15:0]PAYLOAD_LENGTH, input FULLD,HUGEN);





//==============clock===============

	property pclk_check;
		
		real time1,time2,t_period=10;

		@(posedge pclk_i) (1,time1=$realtime)	##1	(1,time2=$realtime)	 |-> (time2-time1==t_period);	

	endproperty 
	assert  property(pclk_check)	$info("PCLK PASS");	else	$warning("Ppclk_i Fail");

	property mpclk_check;
		real time1,time2,t_period=40;
		@(posedge MTxCLK)	(1,time1=$realtime)	##1 (1,time2=$realtime)	|-> (time2 -time1==t_period);
	endproperty 
	assert  property(mpclk_check)	$info("MTxClk PASS");	else	$warning("MTxClk Fail");
	
/*

//=========== MTxEn int_o===========

	property MTxEn_fell_int_o_rose;
		@(posedge MTxCLK)

		$fell(MTxEn)	|-> ##[1:5](int_o);// need to remove delay 
	endproperty

		assert property (MTxEn_fell_int_o_rose)
  						 $info($time,"MTxEn_fell_int_o_rose pass");
		else
						$warning($time,"MTxEn_fell_int_o_rose fial");
*/
//===========MTxEn  MTxD========

		
	property MTxEn_MTxD;
		@(posedge MTxCLK)
			MTxEn  	|-> !($isunknown (MTxD));
	endproperty
		assert property(MTxEn_MTxD)
				$info("MTxEn_MTxD",$sformatf("payload is known pass") );
		else
				$info("MTxEn_MTxD",$sformatf("payload is known ") );
				
				
	property	mtxen_check;
		@(posedge MTxCLK)	$rose(MTxEn) |-> $rose(MCrS);
	endproperty
			assert property(mtxen_check)
				$info("mtxen_check",$sformatf("MTXEN PASS") );
		else
				$info("mtxen_check",$sformatf("MTXEN FAIl ") );
				
				

//================ moder config then MTXEn raised =====

	property MTxEn_raised;

		@(posedge pclk_i) disable iff(!prstn_i)
			 paddr_i==0 && pwdata_i[1]==1 |-> ##[0:$] $rose(MTxEn);
		endproperty
	
		assert property(MTxEn_raised)
				$info("MTxEn_raised  Pass");
		else
				$info("MTxEn_raised fail");
	


//=========================== preable when nopre=1


	
	property  preamble_with_nopre0;
		@(posedge pclk_i)disable iff(!prstn_i && NOPRE ==0)
      (MTxD==5)[*14] |=> (MTxD== 13) |=> (MTxD==5);	
	endproperty

		assert property(preamble_with_nopre0)
				$info("preamble_with_nopre0",$sformatf("pass"));
		else
				$info("preamble_with_nopre0",$sformatf("fail"));
	



//=======================preabmble when===== 

	property preamble_with_nopre1;
		@(posedge pclk_i)disable iff (!prstn_i && NOPRE==1)
      $rose (MTxEn)	|=>	(MTxD== 13) |=> (MTxD==5);	
	endproperty
			
		assert property(preamble_with_nopre0)
				$info("preamble_with_nopre0",$sformatf("pass") );
		else
				$info("preamble_with_nopre0",$sformatf("fail") );



//=====================when	MTxEn TxEn================================

/*	property MTxEn_TxEn;
		@(posedge MTxCLK)disable iff (!prstn_i)
				(MTxEn== 0) throughout  (TxEn==0);	
	endproperty
			
		assert property(MTxEn_TxEn)
				$info("MTxEn_TxEn",$sformatf("pass") );
		else
				$info("MTxEn_TxEn",$sformatf("fail") );
*/

//====== IFG==1 for tx IFG is 1 always
	property IFG_1;
		//@(posedge MTxCLK)disable iff (!prstn_i)
		@(posedge MTxCLK)disable iff (MTxEn)

      $fell(int_o)  |=> (MTxEn ==0)[*24]	
	endproperty
			
		assert property(IFG_1)

				$info("IFG_1",$sformatf("pass") );
		else
				$info("IFG_1",$sformatf("fail") );



//============== MTxEn deasserted when int_o is raised 
	
	property MTxEn_fell_int_o_rose;
		
			@(posedge MTxCLK)disable iff (!prstn_i)
		

				$fell(MTxEn) |-> ##[0:$] $rose(int_o);	
	endproperty
			
		assert property(MTxEn_fell_int_o_rose)

				$info("deasserted when int_o is raised",$sformatf("pass") );
		else
				$info("deasserted when int_o is raised",$sformatf("fail") );


//8============ TxB or TxE needs to be updated by design but depends on IRQ,TxEn,TxB

	property txb_txe_update_check;
		
			@(posedge pclk_i)
		

				$rose(int_o) && pwrite_i==0 && paddr_i=='h04 |-> ##[*] (prdata_o==0)|| (prdata_o==1)||(prdata_o==2); 	
	endproperty
			
		assert property(txb_txe_update_check)

				$info("txb_txe_update_check",$sformatf("pass") );
		else
				$info("txb_txe_update_check",$sformatf("fail") );


//9============ HUGEN=1 int_o raised between 0 to (2030*2)

/*	property HUGEN_1_int_o_rose;
		
			@(posedge MTxCLK)
				(moder[14]==1)  |->  ##[1:5004] $rose(int_o); // depends on max payload data 	
	endproperty
			
		assert property(HUGEN_1_int_o_rose)

				$info("HUGEN_1_int_o_rose",$sformatf("pass") );
		else
				$info("HUGEN_1_int_o_rose",$sformatf("fail") );
*/

//10=================== moder configuration =========================
	sequence setup;

		(psel_i==1) && (penable_i== 0);
	endsequence 

	sequence access;
		(psel_i==1) && (penable_i==1);

	endsequence 


/*
	property moder_configuration;
		
			@(posedge pclk_i )disable iff (!prstn_i)

				setup && pwrite_i && paddr_i=='h00 |=>
				
				access && pwrite_i && $past(paddr_i) |-> moder ==pwdata_i;
						
	endproperty
			
		assert property(moder_configuration)

				$info("moder_configuration",$sformatf("pass") );
		else
				$info("moder_configuration",$sformatf("fail") );


//11=================== int_source configuration =========================
	
	property int_souce_configuration;
		
			@(posedge pclk_i )disable iff (!prstn_i)

				setup && pwrite_i && paddr_i=='h04 |=>
				
				access && pwrite_i && $past(paddr_i) |-> moder ==pwdata_i;
						
	endproperty
			
		assert property(int_souce_configuration)

				$info("int_souce_configuration",$sformatf("pass") );
		else
				$info("int_souce_configuration",$sformatf("fail") );


//12=================== int_mask configuration =========================
	
	property int_mask_configuration;
		
			@(posedge pclk_i )disable iff (!prstn_i)

				setup && pwrite_i && paddr_i=='h08 |=>
				
				access && pwrite_i && $past(paddr_i) |-> moder ==pwdata_i;
						
	endproperty
			
		assert property(int_mask_configuration)

				$info("int_mask_configuration",$sformatf("pass") );
		else
				$info("int_mask_configuration",$sformatf("fail") );

//13=================== int_mask configuration =========================
	
	property Tx_BD_num_configuration;
		
			@(posedge pclk_i )disable iff (!prstn_i)

				setup && pwrite_i && paddr_i=='h20 |=>
				
				access && pwrite_i && $past(paddr_i) |-> moder ==pwdata_i;
						
	endproperty
			
		assert property(Tx_BD_num_configuration)

				$info("Tx_BD_num_configuration",$sformatf("pass") );
		else
				$info("Tx_BD_num_configuration",$sformatf("fail") );


//14=================== MII ADD configuration =========================
	
	property MII_addr_configuration;
		
			@(posedge pclk_i )disable iff (!prstn_i)

				setup && pwrite_i && paddr_i=='h30 |=>
				
				access && pwrite_i && $past(paddr_i) |-> moder ==pwdata_i;
						
	endproperty
			
		assert property(MII_addr_configuration)

				$info("MII_addr_configuration",$sformatf("pass") );
		else
				$info("MII_addr_configuration",$sformatf("fail") );


 

		assert property(Tx_BD_num_configuration)

				$info("Tx_BD_num_configuration",$sformatf("pass") );
		else
				$info("Tx_BD_num_configuration",$sformatf("fail") );


 //15=================== MAC ADD configuration =========================
	
	property MAC_addr0_configuration;
		
			@(posedge pclk_i )disable iff (!prstn_i)

				setup && pwrite_i && paddr_i=='h40 |=>
				
				access && pwrite_i && $past(paddr_i) |-> moder ==pwdata_i;
						
	endproperty
			
		assert property(MII_addr_configuration)

				$info("MAC_addr0_configuration",$sformatf("pass") );
		else
				$info("MAC_addr0_configuration",$sformatf("fail") );


 //16=================== MAC ADD configuration =========================
	
	property MAC_addr1_configuration;
		
			@(posedge pclk_i )disable iff (!prstn_i)

				setup && pwrite_i && paddr_i=='h44 |=>
				
				access && pwrite_i && $past(paddr_i) |-> moder ==pwdata_i;
						
	endproperty
			
		assert property(MII_addr_configuration)

				$info("MAC_addr1_configuration",$sformatf("pass") );
		else
				$info("MAC_addr1_configuration",$sformatf("fail") );

*/




//17============ MCrS should be asserted after MTxEn is asserted 

	property MCrs_MTxEn;
		
			@(posedge MTxCLK)
		

				$rose(MTxEn) |-> $past(MCrS==0) && (MCrS==1);	
	endproperty
			
		assert property(MCrs_MTxEn)

				$info("MCrs_MTxEn",$sformatf("pass") );
		else
				$info("MCrs_MTxEn",$sformatf("fail") );


	sequence  wr_no_err;
		paddr_i==$past(paddr_i) && pwdata_i==$past(pwdata_i) && pwrite_i==$past(pwrite_i);
	endsequence

	sequence rd_no_err;
		paddr_i==$past(paddr_i) && pwrite_i==$past(pwrite_i);
	endsequence

	sequence write;
		pwrite_i ##0 ##[1:3]penable_i ##0 pready_o;
		//pwrite_i |-> ##[1:3]penable_i |-> pready_o;                                   // "->" not allowed inside sequence  
	endsequence

	sequence read;
		!pwrite_i ##0 ##[1:3]penable_i ##0  ##[1:3]pready_o | !($isunknown(prdata_o));
		//!pwrite_i |-> ##[1:3]penable_i |-> ##[1:3]pready_o | !($isunknown(prdata_o));
	endsequence	

	sequence write_check;
		prstn_i ##0 psel_i throughout write;	
	endsequence

	sequence read_check;
		prstn_i ##0 psel_i throughout read;
		//prstn_i |-> psel_i throughout !pwrite_i |-> ##[1:3]penable_i |-> ##[1:3]pready_o | !($isunknown(prdata_o));
	endsequence


          
//====================================

	//18========================== 

	property mprdata_i_ckeck;
		
			@(posedge pclk_i) 
		

				(access) |-> !($isunknown(m_prdata_i) );	
	endproperty
			
		assert property(mprdata_i_ckeck)

				$info("mprdata_i_ckeck",$sformatf("pass") );
		else
				$info("mprdata_i_ckeck",$sformatf("fail") );




//19========================== 

	property mprdata_o_mprdata_i_mpwdata_o_m_pwrite_o;
		
			@(posedge pclk_i) 

				(access) |-> ((m_paddr_o)== $past(m_paddr_o)) &&  ((m_prdata_i) == $past(m_prdata_i))   && ((m_pwdata_o)==$past(m_pwrite_o));
	endproperty
			
		assert property(mprdata_o_mprdata_i_mpwdata_o_m_pwrite_o)

				$info("mprdata_o_mprdata_i_mpwdata_o_m_pwrite_o",$sformatf("pass") );
		else
				$info("mprdata_o_mprdata_i_mpwdata_o_m_pwrite_o",$sformatf("fail") );


//20========================== 

	property m_prdata_i_m_pwrite_o;
		
			@(posedge pclk_i) 

			m_pready_i within m_penable_o;
	endproperty
			
		assert property(m_prdata_i_m_pwrite_o)

				$info("m_prdata_i_m_pwrite_o",$sformatf("pass") );
		else
				$info("m_prdata_i_m_pwrite_o",$sformatf("fail") );



//21========================== 

	property m_psel_o_throughout_m_penable_o;
		
			@(posedge pclk_i) 

			m_psel_o throughout  (m_penable_o);
	endproperty
			
		assert property(m_psel_o_throughout_m_penable_o)

				$info("m_psel_o_m_penable_o",$sformatf("pass") );
		else
				$info("m_psel_o_m_penable_o",$sformatf("fail") );


//22============================

	property pready_i_within_m_psel_o_m_penable_o;
		
			@(posedge pclk_i) 

      m_pready_i within  (m_psel_o) && (m_penable_o);
	endproperty
			
		assert property(pready_i_within_m_psel_o_m_penable_o)

				$info("m_psel_o_m_penable_o",$sformatf("pass") );
		else
				$info("m_psel_o_m_penable_o",$sformatf("fail") );


	//****************************************************************************************//
	//											 PROPERTIES  	  							  //
	//****************************************************************************************//


	//=========CLOCKING BLOCK=========//

	property pready_penable;
		@(posedge pclk_i)	 psel_i==1 && penable_i==1	 |-> ##[1:3]pready_o;
	endproperty

	//=========== ERROR CHECKING CONDITION FOR WRITE =======================// 
	property wr_pslverr_penable;
		@(posedge pclk_i)(prstn_i && psel_i && penable_i && pready_o )|-> (paddr_i==$past(paddr_i) && pwdata_i==$past(pwdata_i) && pwrite_i==$past(pwrite_i)) ;
	endproperty

	//=========== ERROR CHECKING CONDITION FOR READ =======================// 
	property rd_pslverr_penable;
		@(posedge pclk_i)(prstn_i && psel_i && penable_i && pready_o )|->(paddr_i==$past(paddr_i) && prdata_o==$past(prdata_o));
	endproperty

	//=========== ENABLE RAISED IN BETWEEN psel_i ================================//
	property pselx_penable;
		@(posedge pclk_i)  psel_i |-> ##[1:3]penable_i;
	endproperty

/*	//=========write without wait=============================//
	property pready_onter_wwrite;
		@(posedge pclk_i)(prstn_i && pwrite_i && psel_i && penable_i)|-> penable_i |-> ##[1:3]pready_o;   //throughout
	endproperty	
*/

	//======== BASIC WRITE OPERATION =========================//
	property write_operation;
		@(posedge pclk_i)  pwrite_i==0 && prstn_i==1 |-> psel_i throughout pwrite_i |-> ##[1:3]penable_i |-> ##[1:9]pready_o;
	endproperty

	//======== READ OPERATION CHECKING UNKNOWN =========================//
	property read_operation;
		@(posedge pclk_i) pwrite_i ==0 && prstn_i==1 |-> psel_i throughout !pwrite_i |-> ##[1:3]penable_i |-> ##[*]pready_o | !($isunknown(prdata_o));
	endproperty


	//****************************************************************************************//
	//											ASSERTING PROPERTIES 						 //
	//****************************************************************************************//


	assert property(pready_penable) $info($time,"\t pready_penable PASSED"); 
	else $info($time,"\t pready_penable FAILED");
	
	assert property(wr_pslverr_penable) $info($time,"\t wr_pslverr_penable PASSED");
	else $info($time,"\t wr_pslverr_penable FAILED");
	
	assert property(rd_pslverr_penable) $info($time,"\t rd_pslverr_penable PASSED");
	else $info($time,"\t rd_pslverr_penable FAILED");
	
	assert property(pselx_penable) $info($time,"\t pselx_penable PASSED");
	else $info($time,"\t pselx_penable FAILED");
	
/*	assert property(pready_onter_wwrite) $info($time,"\t 6 PASSED");
	else $info($time,"\t 6 FAILED");
*/	
	assert property(write_operation) $info($time,"\t write_operation PASSED");
	else $info($time,"\t write_operation FAILED");
	
	assert property(read_operation) $info($time,"\t read_operation PASSED");
	else $info($time,"\t read_operation FAILED");
	
endmodule	
