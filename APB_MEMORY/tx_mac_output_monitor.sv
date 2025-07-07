//==================== tx_mac_outputmonitor==========//

class tx_mac_outmon  extends uvm_monitor;

	`uvm_component_utils(tx_mac_outmon)

	virtual inter intf;

	ethernet_config_class h_config;

	uvm_analysis_port #(nibble_type) h_analysis_port_outmon;

	ethernet_sequence_item h_ethernet_sequence_item;

	uvm_event		sb_trigger;
	
	bit [31:0]nibble_counter;  //-------------- COUNTER FOR NUMBER OF NIBBLE TRANSFERED
	bit [11:0]bd_addr=1024;

	bit [12:0]len_limit;   //---------------------- for length deciding
	

	function new(string name="tx_mac_outmon",uvm_component parent);

		super.new(name,parent);

	endfunction


	//==================== BUILD_PHASE ==========================//

	function void build_phase(uvm_phase phase);
			
				super.build_phase(phase);

				h_ethernet_sequence_item=new("h_ethernet_sequence_item");
				
				sb_trigger	=	uvm_event_pool::get_global("event");

				//h_analysis_port_outmon=new("h_analysis_port_outmon",this);
							
		endfunction
	



	//====================== CONNECT_PHASE ==================//
	
	function void connect_phase(uvm_phase phase);

				super.connect_phase(phase);
	
			assert((uvm_config_db #(virtual inter)::get(this,this.get_full_name(),"inter",intf)) );
			assert((uvm_config_db #(ethernet_config_class)::get(null,this.get_full_name(),"ethernet_config_class",h_config)));

	endfunction




	//=================== RUN_PHASE =========================//


	task run_phase(uvm_phase phase);

     super.run_phase(phase);
			
			forever@(intf.cb_tx_mac_monitor)begin//{ 1
			
					h_ethernet_sequence_item.MTxEn	=intf.cb_tx_mac_monitor.MTxEn;
					h_ethernet_sequence_item.MTxErr	=intf.cb_tx_mac_monitor.MTxErr;	
					h_ethernet_sequence_item.MTxD	= intf.cb_tx_mac_monitor.MTxD;
					h_ethernet_sequence_item.MCrS	= intf.cb_tx_mac_monitor.MCrS;
					h_ethernet_sequence_item.prstn_i=intf.cb_host_monitor.prstn_i;

	
				$display($time,"\t \t >>>>>>>>>>>>>> present: MTxD:%d MTxEn:%d  TXEN:%d \n",h_ethernet_sequence_item.MTxD,h_ethernet_sequence_item.MTxEn,h_config.moder.TXEN);
				
					//if(h_config.moder.TXEN && h_ethernet_sequence_item.MTxEn && !h_ethernet_sequence_item.MCrS)       
					if(h_ethernet_sequence_item.prstn_i && h_config.moder.TXEN && h_ethernet_sequence_item.MTxEn)        //checking if TXEN is enabled or not
						// MCrS doubt
					  self_check;

					
					else begin//{
						//`uvm_info("SELF_CHECK WAIT",$sformatf("\t \t \t =========== WAITING FOR TXEN AND MTxEn ===========\n"),UVM_HIGH);
						$display($time,"\t \t WAITING ");
						$display($time,"\t \t VALUES OF MTxEn=%d   TXEN=%d   RESET=%d ",h_ethernet_sequence_item.MTxEn,h_config.moder.TXEN,h_ethernet_sequence_item.prstn_i );
					end//}


			end//} 1
	endtask





	task self_check;

		
		if( h_config.TXD0[bd_addr].LENGTH >4 && h_config.TXD0[bd_addr].LENGTH <46 && h_config.moder.PAD ) len_limit=92;

		else if(h_config.TXD0[bd_addr].LENGTH >=46 && h_config.TXD0[bd_addr].LENGTH <=1500 ) len_limit= (h_config.TXD0[bd_addr].LENGTH)*2;
		
		else if(h_config.TXD0[bd_addr].LENGTH >=1501 && h_config.TXD0[bd_addr].LENGTH <=2030 && h_config.moder.HUGEN)  len_limit= (h_config.TXD0[bd_addr].LENGTH)*2;

		



		//================== WITH PREAMBLE =======================================//
		
		if(!h_config.moder.NOPRE)begin//{
			
			if( nibble_counter<=13 )preamble_check;

			else if(nibble_counter>=14 && nibble_counter<=15 ) sfd_check_with_preamble;	

			else if( nibble_counter>=16 && nibble_counter<=27 ) dest_check;	

			else if(nibble_counter>=28 && nibble_counter<=39 ) source_check;	

			else if(nibble_counter>= 40 && nibble_counter<=43 ) length_check;

			//===============================  PAYLOAD_CHECK_WITH_PREAMBLE =================================================//
		
			else if(nibble_counter>= 44 && nibble_counter<= ( len_limit-1+44 ) )  //ELSE OR ELSE IF
																							
																							// len_limit=LENGTH*2 ; BYTE TO NIBBLE CONVERSION    //44 IS LAST COUNT WITH PREAMBLE  //8 IS CRC IN NIBBLES
				payload_export;

			
			else if( nibble_counter >= ( len_limit+44 )  && nibble_counter<=((len_limit)-1+(44+8) ))   //ELSE OR ELSE IF
				
				crc_export;



		end//}




		//================== WITHOUT PREAMBLE =======================================//

		if(h_config.moder.NOPRE)begin//{

			if ( nibble_counter<=1 ) sfd_check_without_preamble;	

			else if( nibble_counter>=2 && nibble_counter<=13 ) dest_check;		

			else if( nibble_counter>=14 && nibble_counter<=25 ) source_check;	

			else if( nibble_counter>= 26 && nibble_counter<=29 ) length_check;
		
			//===============================  PAYLOAD_CHECK_WITHOUT_PREAMBLE =================================================//		
		
			else if(nibble_counter>= 30 && nibble_counter<= ( len_limit-1+30 ) )  //ELSE OR ELSE IF
			
																								// LENGTH*2 BYTE TO NIBBLE CONVERSION    //30 IS LAST COUNT WITH PREAMBLE  //8 IS CRC IN NIBBLES
				payload_export;
			
			
			else if( nibble_counter >= ( len_limit+30 )  && nibble_counter<=((len_limit)-1+(30+8) ))   //ELSE OR ELSE IF
				
				crc_export;



		end//}
		

		

	endtask









//_____________________________________________________________________________________________________________________________________________________________________________________




	//========================================= PREAMBLE_CHECK ===============================================//

	task preamble_check;
		if(h_ethernet_sequence_item.MTxD=='d5)begin
			`uvm_info("preamble_check_pass",$sformatf("\t \t \t ===========PASS  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end
		else begin
			`uvm_info("preamble_check_fail",$sformatf("\t \t \t=========== FAIL at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end

		nibble_counter++;
		
	endtask



	//========================================= SFD_CHECK_WITH_PREAMBLE ===============================================//

	task sfd_check_with_preamble;
		
		if(nibble_counter==14 && h_ethernet_sequence_item.MTxD=='d13)begin//{
			`uvm_info("sfd_check_with_preamble_pass",$sformatf("\t \t \t===========PASS  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end//}		

		else if(nibble_counter==15 && h_ethernet_sequence_item.MTxD=='d5)begin//{
			`uvm_info("sfd_check_with_preamble_pass",$sformatf("\t \t \t===========PASS  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end//}

		else begin//{
			`uvm_info("sfd_check_with_preamble_fail",$sformatf("\t \t \t===========FAIL  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);		
		end//}


		nibble_counter++;

	endtask
	
	
	//========================================= SFD_CHECK_WITHOUT_PREAMBLE ===============================================//

	task sfd_check_without_preamble;
		
		if(nibble_counter==0  && h_ethernet_sequence_item.MTxD=='d13)begin//{
			`uvm_info("sfd_check_without_preamble_pass",$sformatf("\t \t \t===========PASS  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end//}
		
		else if(nibble_counter==1  && h_ethernet_sequence_item.MTxD=='d5)begin//{
			`uvm_info("sfd_check_without_preamble_pass",$sformatf("\t \t \t===========PASS  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end//}
		
		else begin//{
			`uvm_info("sfd_check_with_preamble_fail",$sformatf("\t \t \t===========FAIL  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);		
		end//}


		nibble_counter++;

	endtask



	//========================================= DEST_CHECK_WITH_PREAMBLE ===============================================//

	task dest_check;
		static bit [3:0]dest_queue[$];
	  
		bit [47:0]temp_dest,dut_dest;
			$display($time,"\t \t \t ** ----sssssss----dest_queue=%p",dest_queue);
		
		dest_queue.push_back(h_ethernet_sequence_item.MTxD);

		if(dest_queue.size==12)begin//{ 1
			
			for(int i=0;i<12;i++)begin//{ 2
				temp_dest[(i*4)+:4]=dest_queue[i];
			end//} 2

		

			
			$display($time,"\t  \t    dest_queue=%p  ",dest_queue);

			if(h_config.DESTINATION_ADDR.MII_ADDR==temp_dest) begin//{
				`uvm_info("dest_check_with_preamble",$sformatf("\t \t \t=========== PASS MII_ADDR=%d  DUT DEST_ADDR=%d ===========",h_config.DESTINATION_ADDR.MII_ADDR,temp_dest),UVM_HIGH);
			end//}
			else begin//{
				`uvm_info("dest_check",$sformatf("\t \t \t=========== FAIL MII_ADDR=%d  DUT DEST_ADDR=%d ===========",h_config.DESTINATION_ADDR.MII_ADDR,temp_dest),UVM_HIGH);
			end//}
			$display($time,"\t \t \t ** --------dest_queue=%p",dest_queue);

			dest_queue.delete();			
		
		end//} 1

		else begin//{ 1
				`uvm_info("dest_check",$sformatf("\t \t \t=========== RECEIVING DESTINATION ADDRESS FROM DUT   nibble counter=%p ===========",nibble_counter),UVM_HIGH);
		end//} 1
		
		nibble_counter++;
		
	endtask





	//========================================= DEST_CHECK_WITH_PREAMBLE ===============================================//

	task source_check;

		static bit [3:0]source_queue[$];
		bit [47:0]temp_source,source_addr;
		
		source_queue.push_back(h_ethernet_sequence_item.MTxD);
		$display($time,"\t \t \t starting -------- source_queue=%p",source_queue);
		
		if(source_queue.size==12)begin//{ 1
			
			for(int i=0;i<12;i++)begin//{ 2
				temp_source[(i*4)+:4]=source_queue[i];
			end//} 2
	
			//======as byte 0 is msb   byte 1 is lsb
			source_addr={h_config.SOURCE_ADDR.MAC_ADDR0[7:0],h_config.SOURCE_ADDR.MAC_ADDR0[15:8],h_config.SOURCE_ADDR.MAC_ADDR0[23:16],h_config.SOURCE_ADDR.MAC_ADDR0[31:24],h_config.SOURCE_ADDR.MAC_ADDR1[15:8],h_config.SOURCE_ADDR.MAC_ADDR1[7:0]};

			$display($time,"\t \t \t ** -------- source_queue=%p",source_queue);
			
			if(source_addr == temp_source)begin//{
				`uvm_info("source_addr",$sformatf("\t \t \t =========== PASS MII_ADDR=%h  DUT SOURCE_ADDR=%h ===========",source_addr,temp_source),UVM_HIGH);
			end//}

			else begin//{
				`uvm_info("source_addr",$sformatf("\t \t \t =========== FAIL MII_ADDR=%h  DUT SOURCE_ADDR=%h ===========",source_addr,temp_source),UVM_HIGH);
			end//}

			
			source_queue.delete();
			
		end//} 1

		else begin//{ 1
				`uvm_info("source_addr",$sformatf("\t \t \t =========== RECEIVING SOURCE ADDRESS FROM DUT nibble counter=%p ===========",nibble_counter),UVM_HIGH);
		end//}
		
		nibble_counter++;
	
		//======================== INVOKING  RD_CHECK OF TXBD ================================================================//
		rd_check;

	endtask







	//========================  RD_CHECK OF TXBD ================================================================//
	task rd_check;
		

		for(int i=0; i<h_config.TX_BD_NUM.TXBD; i++)begin//{ 1
			
			if(h_config.TXD0.exists(bd_addr+8))begin//{ 2
			
				//============= check for true conditions =======================//
				if(h_config.TXD0[bd_addr].RD && ((h_config.TXD0[bd_addr].LENGTH>4 && h_config.TXD0[bd_addr].LENGTH<=45 && h_config.moder.PAD)|(h_config.TXD0[bd_addr].LENGTH>=46 && h_config.TXD0[bd_addr].LENGTH<=1500)|(h_config.TXD0[bd_addr].LENGTH>=1501 && h_config.TXD0[bd_addr].LENGTH<=2030 && h_config.moder.HUGEN)))begin//{
					
					bd_addr=bd_addr;
					
				end//}

				else begin//{

					if(h_config.TXD0.exists(bd_addr+8))
						bd_addr=bd_addr+8;            
				//else 
				//	break;         //----------------end the loop

				end//}
			
			end//} 2

		end//}1
		
	endtask






//========================  _LENGTH_CHECK_ ================================================================//

	task length_check;
		
		static bit [3:0]length_queue[$];
		bit [15:0]length_field;
	
		length_queue.push_back(h_ethernet_sequence_item.MTxD);

		
		
		if(length_queue.size==4)begin//{ 1
			
			for(int i=1;i<=4;i++)begin//{
				//length_field[((i*4)-1) -: 4]=length_queue[i-1];
				length_field[((i*4)) +: 4]=length_queue[i];
			end//}
		$display($time,"\t \t \t +++++++++++++++++++++++++++++++++++++++++++++++++++ length_queue=%p",length_queue);

			if(h_config.TXD0[bd_addr].LENGTH==length_field)begin//{
				`uvm_info("length_check",$sformatf("\t \t \t=========== PASS  DUT:LENGTH FIELD=%d  BD_LENGHT[%d]=%d ===========",length_field,bd_addr,h_config.TXD0[bd_addr].LENGTH),UVM_HIGH);				
			end//}
			else begin//{
				`uvm_info("length_check",$sformatf("\t \t \t=========== FAIL  DUT:LENGTH FIELD=%d  BD_LENGHT[%d]=%d ===========",length_field,bd_addr,h_config.TXD0[bd_addr].LENGTH),UVM_HIGH);					
			end//}

		
		end//} 1

		else begin//{ 1 E
			`uvm_info("length_check",$sformatf("\t \t \t=========== RECEIVING LENGTH FIELD FROM DUT value pf MTxD=%d  nibble_counter=%p ===========",h_ethernet_sequence_item.MTxD,nibble_counter),UVM_HIGH);			
		end//} 1 E

		nibble_counter++;
	endtask



	//========================  PAYLOAD_EXPORTING_TO_SCOREBOARD ================================================================//


	task payload_export;
		
			
		h_ethernet_sequence_item.MTxD=intf.cb_tx_mac_monitor.MTxD;
			
		h_analysis_port_outmon.write(h_ethernet_sequence_item.MTxD);
			
		`uvm_info("payload_export",$sformatf("\t \t \t=========== PASSING DATA TO SCOREBOARD ----	nibble_counter=%d ---- MTxD=%d ===========",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
			
		nibble_counter++;
			

	endtask




	//========================  CRC_EXPORTING_TO_SCOREBOARD ================================================================//


	task crc_export;
		
		if(h_config.TXD0[bd_addr].RD==0)begin//{
			
			nibble_counter=0;
			`uvm_info("crc_export",$sformatf("\t \t \t=========== RESETTING NIBBLE COUNTER TO ZERO(0) ==========="),UVM_HIGH);		
			
		end//}
		
		else begin//{
			
			h_ethernet_sequence_item.MTxD=intf.cb_tx_mac_monitor.MTxD;
			
			//h_analysis_port_outmon.write(h_ethernet_sequence_item);
			
			`uvm_info("crc_export",$sformatf("\t \t \t=========== PASSING CRC TO SCOREBOARD ----	nibble_counter=%d ---- MTxD=%d ===========",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
			
			nibble_counter++;

			
		end//}

	endtask
endclass 



//-----------------------------------------------------------------------------------------------------------------------------------------------------------

//==================== tx_mac_outputmonitor==========//

class tx_mac_outmon_bug  extends tx_mac_outmon;

	`uvm_component_utils(tx_mac_outmon_bug)

	virtual inter intf;

	ethernet_config_class h_config;

	//uvm_analysis_port #(nibble_type) h_analysis_port_outmon;

	ethernet_sequence_item h_ethernet_sequence_item;

	bit [3:0]nibble_crc[$];
	
	uvm_event		sb_trigger;
	
	
	bit [31:0]nibble_counter;  //-------------- COUNTER FOR NUMBER OF NIBBLE TRANSFERED
	bit [11:0]bd_addr=1024;

	bit [12:0]len_limit;   //---------------------- for length deciding
	

	function new(string name="tx_mac_outmon_bug",uvm_component parent);

		super.new(name,parent);

	endfunction


	//==================== BUILD_PHASE ==========================//

	function void build_phase(uvm_phase phase);
			
				//super.build_phase(phase);

				h_ethernet_sequence_item=new("h_ethernet_sequence_item");

				h_analysis_port_outmon=new("h_analysis_port_outmon",this);
				
				sb_trigger	=	uvm_event_pool::get_global("event");
							
		endfunction
	



	//====================== CONNECT_PHASE ==================//
	
	function void connect_phase(uvm_phase phase);

			//super.connect_phase(phase);
	
			assert((uvm_config_db #(virtual inter)::get(this,this.get_full_name(),"inter",intf)) );
			assert((uvm_config_db #(ethernet_config_class)::get(null,this.get_full_name(),"ethernet_config_class",h_config)));

	endfunction




	//=================== RUN_PHASE =========================//


	task run_phase(uvm_phase phase);

     //super.run_phase(phase);
			
			forever@(intf.cb_tx_mac_monitor)begin//{ 1
			
					h_ethernet_sequence_item.MTxEn	=intf.cb_tx_mac_monitor.MTxEn;
					h_ethernet_sequence_item.MTxErr	=intf.cb_tx_mac_monitor.MTxErr;	
					h_ethernet_sequence_item.MTxD	= intf.cb_tx_mac_monitor.MTxD;
					h_ethernet_sequence_item.MCrS	= intf.cb_tx_mac_monitor.MCrS;
					h_ethernet_sequence_item.prstn_i=intf.cb_host_monitor.prstn_i;

	
				$display($time,"\t \t >>>>>>>>>>>>>> present: MTxD:%d MTxEn:%d  TXEN:%d \n",h_ethernet_sequence_item.MTxD,h_ethernet_sequence_item.MTxEn,h_config.moder.TXEN);
				//$display($time,"\t \t \t  bd_addr=%d",bd_addr);
				

					//if(h_config.moder.TXEN)
						//rd_check;

					if(h_ethernet_sequence_item.prstn_i && h_config.moder.TXEN && h_ethernet_sequence_item.MTxEn)begin//{        //checking if TXEN is enabled or not
						// MCrS doubt
					  rd_check;
						packet_check; 
						$display($time,"\t \t \t  bd_addr=%d  RD=%d   PACK=	%d",bd_addr,h_config.TXD0[1024].RD,h_config.pack);

					end//}
					
					else begin//{
						$display($time,"--------------------------------  bd_addr=%d-----------------------------------",bd_addr);						
						$display($time,"\t \t WAITING ");
						$display($time,"\t \t VALUES OF MTxEn=%d   TXEN=%d   RESET=%d ",h_ethernet_sequence_item.MTxEn,h_config.moder.TXEN,h_ethernet_sequence_item.prstn_i );
					end//}


					if(!h_ethernet_sequence_item.MTxEn && nibble_counter>0)begin//{
						`uvm_info("sudden_MTxEN_down",$sformatf("------------------------- SUDDEN MTxEn DOWN     nibble_counter=%d--------------------------",nibble_counter),UVM_NONE);
					end//}


			end//} 1
	endtask





	task packet_check;

		$display($time,"--------------------------------  bd_addr=%d-----------------------------------",bd_addr);
		if(h_config.TXD0[bd_addr].LENGTH >4 && h_config.TXD0[bd_addr].LENGTH <46 && h_config.moder.PAD ) len_limit=92;

		else if(h_config.TXD0[bd_addr].LENGTH >=46 && h_config.TXD0[bd_addr].LENGTH <=1500 ) len_limit= (h_config.TXD0[bd_addr].LENGTH)*2;
		
		else if(h_config.TXD0[bd_addr].LENGTH >=1501 && h_config.TXD0[bd_addr].LENGTH <=2030 && h_config.moder.HUGEN)  len_limit= (h_config.TXD0[bd_addr].LENGTH)*2;

		



		//================== WITH PREAMBLE =======================================//
		
		if(!h_config.moder.NOPRE)begin//{
			
			if( nibble_counter<=13 )preamble_check;

			else if(nibble_counter>=14 && nibble_counter<=15 ) sfd_check_with_preamble;	

			else if( nibble_counter>=16 && nibble_counter<=27 ) dest_check;	

			else if(nibble_counter>=28 && nibble_counter<=39 ) source_check;	

			else if(nibble_counter>= 40 && nibble_counter<=43 ) length_check;

			//===============================  PAYLOAD_CHECK_WITH_PREAMBLE =================================================//
		
			else if(nibble_counter>= 44 && nibble_counter<= ( len_limit-1+44 ) )  //ELSE OR ELSE IF
																							
																							// len_limit=LENGTH*2 ; BYTE TO NIBBLE CONVERSION    //44 IS LAST COUNT WITH PREAMBLE  //8 IS CRC IN NIBBLES
				payload_export;

			
			else if( nibble_counter >= ( len_limit+44 )  && nibble_counter<=((len_limit)-1+(44+8) ))   //ELSE OR ELSE IF
				
				crc_export;



		end//}




		//================== WITHOUT PREAMBLE =======================================//

		if(h_config.moder.NOPRE)begin//{

			if ( nibble_counter<=1 ) sfd_check_without_preamble;	

			else if( nibble_counter>=2 && nibble_counter<=13 ) dest_check;		

			else if( nibble_counter>=14 && nibble_counter<=25 ) source_check;	

			else if( nibble_counter>= 26 && nibble_counter<=29 ) length_check;
		
			//===============================  PAYLOAD_CHECK_WITHOUT_PREAMBLE =================================================//		
		
			else if(nibble_counter>= 30 && nibble_counter<= ( len_limit-1+30 ) )  //ELSE OR ELSE IF
			
																								// LENGTH*2 BYTE TO NIBBLE CONVERSION    //30 IS LAST COUNT WITH PREAMBLE  //8 IS CRC IN NIBBLES
				payload_export;
			
			
			else if( nibble_counter >= ( len_limit+30 )  && nibble_counter<=((len_limit)-1+(30+8) ))   //ELSE OR ELSE IF
				
				crc_export;



		end//}
		

		

	endtask









//_____________________________________________________________________________________________________________________________________________________________________________________




	//========================================= PREAMBLE_CHECK ===============================================//

	task preamble_check;
		if(h_ethernet_sequence_item.MTxD=='d5)begin
			`uvm_info("preamble_check_pass",$sformatf("\t \t \t ===========PASS  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end
		else begin
			`uvm_info("preamble_check_fail",$sformatf("\t \t \t=========== FAIL at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end

		nibble_counter++;
		
	endtask



	//========================================= SFD_CHECK_WITH_PREAMBLE ===============================================//

	task sfd_check_with_preamble;
		
		if(nibble_counter==14 && h_ethernet_sequence_item.MTxD=='d5)begin//{
			`uvm_info("sfd_check_with_preamble_pass",$sformatf("\t \t \t===========PASS  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end//}		

		else if(nibble_counter==15 && h_ethernet_sequence_item.MTxD=='d13)begin//{
			`uvm_info("sfd_check_with_preamble_pass",$sformatf("\t \t \t===========PASS  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end//}

		else begin//{
			`uvm_info("sfd_check_with_preamble_fail",$sformatf("\t \t \t===========FAIL  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);		
		end//}


		nibble_counter++;

	endtask
	
	
	//========================================= SFD_CHECK_WITHOUT_PREAMBLE ===============================================//

	task sfd_check_without_preamble;
		
		if(nibble_counter==0  && h_ethernet_sequence_item.MTxD=='d5)begin//{
			`uvm_info("sfd_check_without_preamble_pass",$sformatf("\t \t \t===========PASS  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end//}
		
		else if(nibble_counter==1  && h_ethernet_sequence_item.MTxD=='d13)begin//{
			`uvm_info("sfd_check_without_preamble_pass",$sformatf("\t \t \t===========PASS  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
		end//}
		
		else begin//{
			`uvm_info("sfd_check_with_preamble_fail",$sformatf("\t \t \t===========FAIL  at nibble_counter=%d =========== MTxD=%d",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);		
		end//}


		nibble_counter++;

	endtask



	//========================================= DEST_CHECK_WITH_PREAMBLE ===============================================//

	task dest_check;
		static bit [3:0]dest_queue[$];
	  
		bit [47:0]temp_dest;  //for storing dest addr received from DUT through MTxD in a single register
		
		bit [47:0]dest_addr;  // configured dest addr in MII_ADDR(to store MII_ADDR as per design pattern)

			$display($time,"\t \t \t ** ----sssssss----dest_queue=%p",dest_queue);
		
		dest_queue.push_back(h_ethernet_sequence_item.MTxD);

		if(dest_queue.size==12)begin//{ 1
			
			for(int i=0;i<12;i++)begin//{ 2
				temp_dest[(i*4)+:4]=dest_queue[i];
			end//} 2

			dest_addr={h_config.DESTINATION_ADDR.MII_ADDR[27:24],h_config.DESTINATION_ADDR.MII_ADDR[31:28],h_config.DESTINATION_ADDR.MII_ADDR[19:16],h_config.DESTINATION_ADDR.MII_ADDR[23:20],h_config.DESTINATION_ADDR.MII_ADDR[11:8],h_config.DESTINATION_ADDR.MII_ADDR[15:12],h_config.DESTINATION_ADDR.MII_ADDR[3:0],h_config.DESTINATION_ADDR.MII_ADDR[7:4]};

			
			$display($time,"\t  \t    dest_queue=%p  ",dest_queue);

			if(dest_addr==temp_dest) begin//{
				`uvm_info("dest_check",$sformatf("\t \t \t=========== PASS MII_ADDR=%d  DUT DEST_ADDR=%d ===========",dest_addr,temp_dest),UVM_HIGH);
				`uvm_info("dest_pass",$sformatf("\t \t \t=============================== PASS =============================================================="),UVM_HIGH);				
				
			end//}
			else begin//{
				`uvm_info("dest_check",$sformatf("\t \t \t=========== FAIL MII_ADDR=%d  DUT DEST_ADDR=%d ===========",dest_addr,temp_dest),UVM_HIGH);
				`uvm_info("dest_fail",$sformatf("\t \t \t=============================== FAIL =============================================================="),UVM_HIGH);								
			end//}
			$display($time,"\t \t \t ** --------dest_queue=%p",dest_queue);

			dest_queue.delete();			
		
		end//} 1

		else begin//{ 1
				`uvm_info("dest_check",$sformatf("\t \t \t=========== RECEIVING DESTINATION ADDRESS FROM DUT  MTxD=%0d nibble counter=%0d ===========",h_ethernet_sequence_item.MTxD,nibble_counter),UVM_HIGH);
		end//} 1
		
		nibble_counter++;
		nibble_crc.push_back(h_ethernet_sequence_item.MTxD);
		//$display($time,"\t \t \t  ---------------  nibble_crc=%p",nibble_crc);
		
		
	endtask





	//========================================= DEST_CHECK_WITH_PREAMBLE ===============================================//

	task source_check;

		static bit [3:0]source_queue[$]; 
		bit [47:0]temp_source;            //---------- for storing source addr received from DUT through MTxD in a single register             
		bit [47:0]source_addr;						//---------- configured  source_addr in MAC_ADDR1,MAC_ADDR0(to store MII_ADDR as per design pattern)
		
		source_queue.push_back(h_ethernet_sequence_item.MTxD);
		$display($time,"\t \t \t starting -------- source_queue=%p",source_queue);
		
		if(source_queue.size==12)begin//{ 1
			
			for(int i=0;i<12;i++)begin//{ 2
				temp_source[(i*4)+:4]=source_queue[i];
			end//} 2
	
			//======as byte 0 is msb   byte 1 is lsb
			source_addr={h_config.SOURCE_ADDR.MAC_ADDR0[7:0],h_config.SOURCE_ADDR.MAC_ADDR0[15:8],h_config.SOURCE_ADDR.MAC_ADDR0[23:16],h_config.SOURCE_ADDR.MAC_ADDR0[31:24],h_config.SOURCE_ADDR.MAC_ADDR1[3:0],h_config.SOURCE_ADDR.MAC_ADDR1[7:4],h_config.SOURCE_ADDR.MAC_ADDR1[11:8],h_config.SOURCE_ADDR.MAC_ADDR1[15:12]};

			$display($time,"\t \t \t ** -------- source_queue=%p",source_queue);
			
			if(source_addr == temp_source)begin//{
				`uvm_info("source_addr",$sformatf("\t \t \t =========== PASS MII_ADDR=%h  DUT SOURCE_ADDR=%h ===========",source_addr,temp_source),UVM_HIGH);
				`uvm_info("source_pass",$sformatf("\t \t \t=============================== PASS =============================================================="),UVM_HIGH);				
			end//}

			else begin//{
				`uvm_info("source_addr",$sformatf("\t \t \t =========== FAIL MII_ADDR=%h  DUT SOURCE_ADDR=%h ===========",source_addr,temp_source),UVM_HIGH);
				`uvm_info("source_fail",$sformatf("\t \t \t=============================== FAIL =============================================================="),UVM_HIGH);
			
			end//}

			
			source_queue.delete();
			
		end//} 1

		else begin//{ 1
				`uvm_info("source_addr",$sformatf("\t \t \t =========== RECEIVING SOURCE ADDRESS FROM DUT nibble counter=%p ===========",nibble_counter),UVM_HIGH);
		end//}
		
		nibble_counter++;
		nibble_crc.push_back(h_ethernet_sequence_item.MTxD);
		//$display($time,"\t \t \t  ---------------  nibble_crc=%p",nibble_crc);
		//======================== INVOKING  RD_CHECK OF TXBD ================================================================//

		//rd_check;

	endtask







	//========================  RD_CHECK OF TXBD ================================================================//
	task rd_check;
		

		for(int i=0; i<h_config.TX_BD_NUM.TXBD; i++)begin//{ 1
			
			if(h_config.TXD0.exists(bd_addr+8))begin//{ 2
			
				//============= check for true conditions =======================//
				if(h_config.TXD0[bd_addr].RD && ((h_config.TXD0[bd_addr].LENGTH>4 && h_config.TXD0[bd_addr].LENGTH<=45 && h_config.moder.PAD)|(h_config.TXD0[bd_addr].LENGTH>=46 && h_config.TXD0[bd_addr].LENGTH<=1500)|(h_config.TXD0[bd_addr].LENGTH>=1501 && h_config.TXD0[bd_addr].LENGTH<=2030 && h_config.moder.HUGEN)))begin//{
					
					bd_addr=bd_addr;
					
				end//}

				else begin//{

					if(h_config.TXD0.exists(bd_addr+8))begin//{
						bd_addr=bd_addr+8; 
						//nibble_counter=0;
					end//}
				//else 
				//	break;         //----------------end the loop

				end//}
			
			end//} 2


		end//}1
		
	endtask






//========================  _LENGTH_CHECK_ ================================================================//

	task length_check;
		
		static bit [3:0]length_queue[$];
		bit [15:0]length_field;  //---------- for storing length received from DUT through MTxD in a single register (i.e; packet field)
		bit [15:0]bd_length;		 //---------- bd_length of current bd
		
		length_queue.push_back(h_ethernet_sequence_item.MTxD);

		
	  $display($time,"\t \t \t starting----------------- length_queue=%p",length_queue);				
		
		if(length_queue.size==4)begin//{ 1
			
			for(int i=0;i<4;i++)begin//{
				length_field[((i*4)) +: 4]=length_queue[i];
			end//}

			//bd_length={h_config.TXD0[bd_addr].LENGTH[11:8],h_config.TXD0[bd_addr].LENGTH[15:12],h_config.TXD0[bd_addr].LENGTH[3:0],h_config.TXD0[bd_addr].LENGTH[7:4]};
			bd_length={h_config.TXD0[bd_addr].LENGTH[7:4],h_config.TXD0[bd_addr].LENGTH[3:0],h_config.TXD0[bd_addr].LENGTH[15:12],h_config.TXD0[bd_addr].LENGTH[11:8]};
			
			$display($time,"\t \t \t +++++++++++++++++++++++++++++++++++++++++++++++++++ length_queue=%p",length_queue);
			$display($time,"\t \t \t [length_check] h_config.TXD0[%0d].LENGTH[11:8]=%0d   h_config.TXD0[%0d].LENGTH[15:12]=%0d   h_config.TXD0[%0d].LENGTH[3:0]=%0d   h_config.TXD0[%0d].LENGTH[7:4]=%0d",bd_addr,h_config.TXD0[bd_addr].LENGTH[11:8],bd_addr,h_config.TXD0[bd_addr].LENGTH[15:12],bd_addr,h_config.TXD0[bd_addr].LENGTH[3:0],bd_addr,h_config.TXD0[bd_addr].LENGTH[7:4]);			

			if( bd_length ==length_field)begin//{
				`uvm_info("length_check",$sformatf("\t \t \t=========== PASS  DUT:LENGTH FIELD=%h  BD_LENGHT[%d]=%h ===========",length_field,bd_addr,bd_length),UVM_HIGH);
				`uvm_info("length_pass",$sformatf("\t \t \t=============================== PASS =============================================================="),UVM_HIGH);
				
			end//}
			else begin//{
				`uvm_info("length_check",$sformatf("\t \t \t=========== FAIL  DUT:LENGTH FIELD=%d  BD_LENGHT[%d]=%d ===========",length_field,bd_addr,bd_length),UVM_HIGH);
				`uvm_info("length_fail",$sformatf("\t \t \t=============================== FAIL =============================================================="),UVM_HIGH);

			end//}
			
			length_queue.delete();
		
		end//} 1

		else begin//{ 1 E
			`uvm_info("length_check",$sformatf("\t \t \t=========== RECEIVING LENGTH FIELD FROM DUT value pf MTxD=%d  nibble_counter=%p ===========",h_ethernet_sequence_item.MTxD,nibble_counter),UVM_HIGH);			
		end//} 1 E

		nibble_counter++;
		nibble_crc.push_back(h_ethernet_sequence_item.MTxD);
		//$display($time,"\t \t \t  ---------------  nibble_crc=%p",nibble_crc);

	endtask



	//========================  PAYLOAD_EXPORTING_TO_SCOREBOARD ================================================================//


	task payload_export;
		
			
		h_ethernet_sequence_item.MTxD=intf.cb_tx_mac_monitor.MTxD;
			
		h_analysis_port_outmon.write(h_ethernet_sequence_item.MTxD);
		
		sb_trigger.trigger;
			
		`uvm_info("payload_export",$sformatf("\t \t \t=========== PASSING DATA TO SCOREBOARD ----	nibble_counter=%d ---- MTxD=%d ===========",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
			
		nibble_counter++;
		
		nibble_crc.push_back(h_ethernet_sequence_item.MTxD);
		//$display($time,"\t \t \t  ---------------  nibble_crc=%p",nibble_crc);
			

	endtask




	//========================  CRC_EXPORTING_TO_SCOREBOARD ================================================================//


	task crc_export;

			h_ethernet_sequence_item.MTxD=intf.cb_tx_mac_monitor.MTxD;
			
			
			`uvm_info("crc_export",$sformatf("\t \t \t=========== PASSING CRC TO SCOREBOARD ----	nibble_counter=%d ---- MTxD=%d ===========",nibble_counter,h_ethernet_sequence_item.MTxD),UVM_HIGH);
			
			nibble_counter++;
			
			nibble_crc.push_back(h_ethernet_sequence_item.MTxD);
			//$display($time,"\t \t \t  ---------------  nibble_crc=%p",nibble_crc);

			if(nibble_counter==(len_limit+30+8) && h_config.moder.NOPRE ) begin ///{
				crc_check;
			end//}
			
			if(nibble_counter==(len_limit+44+8) && !h_config.moder.NOPRE)begin//{
				crc_check;
			end//}


			
		//end//}

	endtask







	task crc_check;
		
		bit [3:0] data;
		bit [31:0] crc_variable = 32'hffff_ffff; // initializing the variable
		bit [31:0] crc_next; 
		bit [31:0] calculated_magic_number;
		int nibble_size;
		
		nibble_size = nibble_crc.size;
	
			for(int i=0;i<nibble_size;i++) 
			begin
			data = nibble_crc.pop_front;
			data = {<<{data}}; 

			crc_next[0] =    (data[0] ^ crc_variable[28]); 
			crc_next[1] =    (data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29]); 
			crc_next[2] =    (data[2] ^ data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29] ^ crc_variable[30]); 
			crc_next[3] =    (data[3] ^ data[2] ^ data[1] ^ crc_variable[29] ^ crc_variable[30] ^ crc_variable[31]); 
			crc_next[4] =    (data[3] ^ data[2] ^ data[0] ^ crc_variable[28] ^ crc_variable[30] ^ crc_variable[31]) ^ crc_variable[0]; 
			crc_next[5] =    (data[3] ^ data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29] ^ crc_variable[31]) ^ crc_variable[1]; 
			crc_next[6] =    (data[2] ^ data[1] ^ crc_variable[29] ^ crc_variable[30]) ^ crc_variable[2]; 
			crc_next[7] =    (data[3] ^ data[2] ^ data[0] ^ crc_variable[28] ^ crc_variable[30] ^ crc_variable[31]) ^ crc_variable[3]; 
			crc_next[8] =    (data[3] ^ data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29] ^ crc_variable[31]) ^ crc_variable[4]; 
			crc_next[9] =    (data[2] ^ data[1] ^ crc_variable[29] ^ crc_variable[30]) ^ crc_variable[5]; 
			crc_next[10] =    (data[3] ^ data[2] ^ data[0] ^ crc_variable[28] ^ crc_variable[30] ^ crc_variable[31]) ^ crc_variable[6]; 
			crc_next[11] =    (data[3] ^ data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29] ^ crc_variable[31]) ^ crc_variable[7]; 
			crc_next[12] =    (data[2] ^ data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29] ^ crc_variable[30]) ^ crc_variable[8]; 
			crc_next[13] =    (data[3] ^ data[2] ^ data[1] ^ crc_variable[29] ^ crc_variable[30] ^ crc_variable[31]) ^ crc_variable[9]; 
			crc_next[14] =    (data[3] ^ data[2] ^ crc_variable[30] ^ crc_variable[31]) ^ crc_variable[10]; 
			crc_next[15] =    (data[3] ^ crc_variable[31]) ^ crc_variable[11]; 
			crc_next[16] =    (data[0] ^ crc_variable[28]) ^ crc_variable[12]; 
			crc_next[17] =    (data[1] ^ crc_variable[29]) ^ crc_variable[13]; 
			crc_next[18] =    (data[2] ^ crc_variable[30]) ^ crc_variable[14]; 
			crc_next[19] =    (data[3] ^ crc_variable[31]) ^ crc_variable[15]; 
			crc_next[20] = 	  crc_variable[16]; 
			crc_next[21] =    crc_variable[17]; 
			crc_next[22] =    (data[0] ^ crc_variable[28]) ^ crc_variable[18]; 
			crc_next[23] =    (data[1] ^ data[0] ^ crc_variable[29] ^ crc_variable[28]) ^ crc_variable[19]; 
			crc_next[24] =    (data[2] ^ data[1] ^ crc_variable[30] ^ crc_variable[29]) ^ crc_variable[20]; 
			crc_next[25] =    (data[3] ^ data[2] ^ crc_variable[31] ^ crc_variable[30]) ^ crc_variable[21]; 
			crc_next[26] =    (data[3] ^ data[0] ^ crc_variable[31] ^ crc_variable[28]) ^ crc_variable[22]; 
			crc_next[27] =    (data[1] ^ crc_variable[29]) ^ crc_variable[23]; 
			crc_next[28] =    (data[2] ^ crc_variable[30]) ^ crc_variable[24]; 
			crc_next[29] =    (data[3] ^ crc_variable[31]) ^ crc_variable[25]; 
			crc_next[30] =    crc_variable[26]; 
			crc_next[31] =    crc_variable[27]; 

			crc_variable = crc_next;

			end
		
		calculated_magic_number = crc_variable;

		if(calculated_magic_number == 32'hc704dd7b)begin//{
			
			`uvm_info("crc_pass",$sformatf("\t \t \t=========== PASS ----	nibble_counter=%d ---- magic_number=32'hc704dd7b  calculated_magic_number = %0h ===========",nibble_counter,calculated_magic_number),UVM_HIGH);

		end//}

		else begin//{
			
			`uvm_info("crc_fail",$sformatf("\t \t \t=========== FAIL ----	nibble_counter=%d ---- magic_number=32'hc704dd7b  calculated_magic_number = %0h ===========",nibble_counter,calculated_magic_number),UVM_HIGH);

		end//}
		`uvm_info("bd_count",$sformatf("PRESENT bd_addr=%d   %h",bd_addr,bd_addr),UVM_HIGH);
		nibble_counter=0;
		h_config.TXD0[bd_addr].RD=0;

		@(intf.cb_tx_mac_monitor);
		@(intf.cb_tx_mac_monitor);         //pack is asserting 1 clock pulse before int_o (reading happening before int_o is asserted TXE/TXB is written while int_o is raised)
		h_config.pack=1;
		
		
		



		
	endtask
	
	
endclass 


