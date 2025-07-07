

class mem_sequence	extends uvm_sequence#(ethernet_sequence_item);

	`uvm_object_utils(mem_sequence)

	ethernet_config_class		h_ethernet_config_class;

	int 	temp_length;
	int 	addr=1024;

	//===================================== object construction ===================================//

		function  new(string name="mem_sequence");
			super.new(name);
		endfunction
	

	//=================================== RUN PHASE =======================================//

		task body;
				

			assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN MEM SEQUENCE");
		
	
//add <4 condition to stiop randomiztion
	
			req=ethernet_sequence_item::type_id::create("req");	


		//	repeat(h_ethernet_config_class.TX_BD_NUM.TXBD)  begin	//{1 tx bd num
			for(int	i=0;i<h_ethernet_config_class.TX_BD_NUM.TXBD;i++)		begin	//{

			$display(">>>>>>>>	i=%0d....txbd's=%0d",i,h_ethernet_config_class.TX_BD_NUM.TXBD);
			if(h_ethernet_config_class.TXD0[addr].RD==1)	begin	//{2
				
 					if((h_ethernet_config_class.TXD0[addr].LENGTH)%4==0)		temp_length=(h_ethernet_config_class.TXD0[addr].LENGTH)/4;
					else														temp_length=(((h_ethernet_config_class.TXD0[addr].LENGTH)/4)+1);
	
				
				repeat(temp_length)	begin	//{	3		//loop repeat to randomize for payload length/4 because it randomizes  32 bits at single instance
		
					start_item(req);
						req.randomize with {m_pready_i==1;/*m_prdata_i=='h1234_5678;*/};
					finish_item(req);

				end //}3
				
				addr=addr+8;
			
			end	//}		2

			else	
				addr=addr+8;
			
			end	//}1
		endtask
endclass
