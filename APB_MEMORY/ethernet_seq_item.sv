//===============================================================================================================================================//
//-----------------------------------------------------------SEQUENCE ITEM-----------------------------------------------------------------------//
//===============================================================================================================================================//


class ethernet_sequence_item extends uvm_sequence_item;

	`uvm_object_utils(ethernet_sequence_item)

	typedef enum{good_packet,bad_packet}packet;							//enum for good and bad conditions
  	typedef enum{l4,l46,l1500,l2030,g2030,random}len_control;			//enum for length controls

		rand packet			data;										//randomizing	data	packet	enum
		rand len_control	length_control;								//randomizing	length control enum

	//============================= host Signals =============================//

			rand bit 			prstn_i;
			rand bit 			psel_i;
			rand bit 			pwrite_i;
			rand bit 			penable_i;
			rand bit	  [31:0]paddr_i;
			rand bit	  [31:0]pwdata_i; 
	

			bit 				pready_o;
			bit 				int_o;
			bit 		  [31:0]prdata_o;



	//============================== Memory signals ==============================//

			rand bit			[31:0]m_prdata_i ;
			rand bit 			  m_pready_i;


			bit				[31:0]m_pwdata_o ;
			bit				[31:0]m_paddr_o; 
			bit 				  m_psel_o ;
			bit 				  m_pwrite_o ;
			bit 				  m_penable_o;

	//=========================== rx mac signals ===================================//

			rand bit		 [3:0]MRxD;
			rand bit 			  MRxErr,MRxDV;
			rand bit 			  MCrS;



	//==========================tx mac signals =====================================//

			bit				[3:0]MTxD;
			bit 				 MTxErr,MTxEn;
	



	//================================ object construction ==========================//

			function new(string name="ethernet_sequence_item");
				super.new(name);
			endfunction




	//=============================== constaraints =====================================//


		constraint		c_rst{soft	prstn_i==1;	soft penable_i==0;}

		constraint		c_write{soft pwrite_i==1;soft psel_i==1;}

		constraint		c_pready{soft m_pready_i==1;}

	//----------------------------------- moder configuration

		constraint		c_moder{if(data==good_packet && paddr_i == 'h0) soft
    								pwdata_i  dist{32'h0000_c042 := 6, 32'h0000_c046 := 4  };	
				//pad=1,hugen=1,fulld=0,loopback=0,ifg=1,nore==0 for c042 & 1 for c046 , txen=1,rxen=0 for good packet
				//nopre is only toggling between 0,1

			
									if(data==bad_packet && paddr_i=='h0)  soft
		                   			 pwdata_i dist{ 32'h0000_0002  := 7,32'h0000_0001  := 1, 32'h0000_0000  := 1,32'h0000_0003  := 1 };	}
			//pad=0,hugen=0,fulld=0,loopback=0,ifg=1,nore==0 , txen=1&rxen=0 for 0002,txen=0&rxen=1 for 0001,txen=0 rxen=0 for 0000,txen=1 rxen=1 for 3
			//txen,rxen is only changing between 00,01,10,11
									
	

	//------------------------------------ TX_BD_NUM   configuration

		constraint		c_tx_bd_num{if(paddr_i=='h20 && data==bad_packet)	 soft 	pwdata_i==0;
									if(paddr_i=='h20 && data==good_packet)   soft	pwdata_i inside {3};	}
			

	//----------------------------------- BD configuration

		constraint		c_bd_conf{	 if(paddr_i>=1024 && paddr_i%8==0)		{
																			if(length_control==l46)		soft	pwdata_i[31:16] inside {[4:45]};
																			if(length_control==l1500)	soft	pwdata_i[31:16] inside {[46:1500]};
																			if(length_control==l2030)	soft	pwdata_i[31:16] inside {[1501:2030]};
																			
																			if(length_control==random)	soft	pwdata_i[31:16]  dist {[5:46]:=3, [46:150]:=5, [1501:2030]:=2};
										

									 										if(length_control==l4)		soft	pwdata_i[31:16] inside {[0:4]};			//payload length
																			if(length_control==g2030)	soft	pwdata_i[31:16] inside {[2030:2100]};
																			soft	pwdata_i[15:14] inside	{3};			//rd & irq				
		           															soft	pwdata_i[13:0]==0;	}					//reserved
																			
																															
									 if(paddr_i>=1024 && paddr_i%8!=0)		{soft	pwdata_i%4==0;
																					soft	pwdata_i inside {[0:1000]};}}


	//--------------------------------------- int mask

		constraint		c_int_mask{		if(paddr_i=='h8)		{soft 	pwdata_i[31:2]==0;	soft	pwdata_i[1:0] inside {[0:3]};}	}


	//--------------------------------------- int SOURCE

		constraint		c_int_source{	if(paddr_i=='h4) 		{soft	pwdata_i[31:2]==0;	soft	pwdata_i[1:0] inside {[0:3]};}}
	

	//---------------------------------- MIIA address configuration

		constraint		c_miia_add{	if(paddr_i=='h30)	{soft	pwdata_i inside {12};}} 
										//we only have access of lsb 4-bits and remaining bits are reserves

	


	//------------------------------------ MAC Adress 0
		
		constraint		c_mac_0{ if(paddr_i=='h40) {soft pwdata_i=='b0;}}



	//------------------------------------ MAC Adress 1
		
		constraint		c_mac_1{ if(paddr_i=='h44) {soft pwdata_i=='habcd;}}

		

	//============================================ post randomization ============================

		function	void	post_randomize();
		
			if(psel_i && !penable_i) begin				//setup state	
				paddr_i.rand_mode(0);			
				pwdata_i.rand_mode(0);
				pwrite_i.rand_mode(0);
			end
	
			if(psel_i && penable_i) begin				//access phase
				paddr_i.rand_mode(1);
				pwdata_i.rand_mode(1);
				pwrite_i.rand_mode(1);
			end
								
		endfunction

		
endclass 
