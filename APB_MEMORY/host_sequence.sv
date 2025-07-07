
class host_sequence	extends uvm_sequence#(ethernet_sequence_item);


		`uvm_object_utils(host_sequence)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="host_sequence");
			super.new(name);

		endfunction
	
	//=========================== penable_i=1  task
		task en_1;
				start_item(req);
				assert(req.randomize with{penable_i==1;});
			finish_item(req);			
		endtask
	//=================================== RUN PHASE =======================================//
		task body;
				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");
			req=ethernet_sequence_item::type_id::create("req");					
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{prstn_i==1;psel_i==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
				start_item(req);
				assert(req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			//--------	BD Configuration	
		for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
              start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==31;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;pwdata_i[31:16]==31;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		
			addr=1024;
		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		//---------	Moder
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;			
		endtask
endclass
//---------------------------------------------------------- write read

class write_read	extends host_sequence;
		`uvm_object_utils(write_read)				//factory registration
		ethernet_config_class	h_ethernet_config_class;
		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="write_read");
			super.new(name);

		endfunction
	//=================================== RUN PHASE =======================================//
		task body;
				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");
			req=ethernet_sequence_item::type_id::create("req");					
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;});
			finish_item(req);en_1;
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});
			finish_item(req);en_1;
	
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});
			finish_item(req);en_1;
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==3;});
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;});
			finish_item(req);en_1;	
		//--------	BD Configuration	
			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==50;});
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;pwdata_i[31:16]==50;});
			finish_item(req);en_1;
           	 addr=addr+4;
			end		
			addr=1024;
		//---------	 INT_MASK
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;});
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});
			finish_item(req);en_1;
		//---------	 INT_SOURCE
			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwdata_i==3;});
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;
		//---------	Moder
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==bad_packet;});
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==bad_packet;pwrite_i==0;});
			finish_item(req);en_1;			
		endtask
endclass
//------------------------------------ moder configuration after testcase

class moder	extends 	uvm_sequence#(ethernet_sequence_item);
		`uvm_object_utils(moder)				//factory registration
		ethernet_config_class	h_ethernet_config_class;
	//===================================== object construction ===================================//
	function  new(string name="moder");
			super.new(name);

		endfunction
  task en_1;		
			start_item(req);
				assert(req.randomize with{penable_i==1;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);			
		endtask
	//=================================== RUN PHASE =======================================//
		task body;
				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");
			req=ethernet_sequence_item::type_id::create("req");					
		//---------WRITE  INT_SOURCE
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwdata_i==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		endtask
endclass

//------------------------------------ int source configuration after BD


class int_source_sequence	extends 	uvm_sequence#(ethernet_sequence_item);


		`uvm_object_utils(int_source_sequence)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

	//===================================== object construction ===================================//

		function  new(string name="int_source_sequence");
			super.new(name);

		endfunction
	


		task en_1;
			
			start_item(req);
				assert(req.randomize with{penable_i==1;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);
			
		endtask

	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			
		//---------READ	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{penable_i==1;});
			finish_item(req);en_1;


		//---------WRITE  INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwdata_i==3;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{penable_i==1;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		//---------READ	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{penable_i==1;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


		endtask
endclass











//------------------------ reset_low ----------------------

	class reset_low	extends	host_sequence;

			

		`uvm_object_utils(reset_low)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="reset_low");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			start_item(req);
				assert(req.randomize with{prstn_i==0;});
			finish_item(req);en_1;
			

		endtask
	endclass


//------------------------------------------ Reset_read

class reset_read	extends host_sequence;


		`uvm_object_utils(reset_read)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="reset_read");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					


	/*		start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
	*/		
		//----------  destination address
		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwrite_i==0;});
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0

			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});
			finish_item(req);en_1;


			
		//--------- source address	mac-1

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});
			finish_item(req);en_1;
			
	
		//---------  TX BD Num	


			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;});
			finish_item(req);en_1;

	
		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;});
			finish_item(req);en_1;


           	 addr=addr+4;
			end		

		//---------	 INT_MASK


			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});
			finish_item(req);en_1;

		

		//---------	 INT_SOURCE

		
			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==bad_packet;pwrite_i==0;});
			finish_item(req);en_1;


		endtask
endclass



//------------------------------------------------------- struck at zero

class struck_at0	extends host_sequence;


		`uvm_object_utils(struck_at0)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="struck_at0");
			super.new(name);
		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					
	
		
/*			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
*/			
		
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwdata_i==0;});
			finish_item(req);en_1;
		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwrite_i==0;});
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwdata_i==0;});
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwdata_i==0;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwdata_i==0;});
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});
			finish_item(req);en_1;
	
		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i==0;pwdata_i==0;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;pwdata_i==0;});
			finish_item(req);en_1;

           	 addr=addr+4;
			end		
			addr=1024;

		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==0;});
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});
			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwdata_i==0;});
			finish_item(req);en_1;
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwdata_i==0;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});
			finish_item(req);en_1;
			
			
		endtask
endclass




//------------------------------------------------------- struck at one

class struck_at1	extends host_sequence;


		`uvm_object_utils(struck_at1)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="struck_at1");
			super.new(name);
		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					
	
		
	/*		start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
	*/		
		
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwdata_i==32'hffff_ffff;});
			finish_item(req);en_1;
		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwrite_i==0;});
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwdata_i=='hffff_ffff;});
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwdata_i=='hffff_ffff;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwdata_i=='d120;});
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});
			finish_item(req);en_1;
	
		//--------	BD Configuration	

			for(int i=0;i<	2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i=='hffff_ffff;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;});
			finish_item(req);en_1;

           	 addr=addr+4;
			end		

		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i=='hffff_ffff;});
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});
			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwdata_i=='hffff_ffff;});
			finish_item(req);en_1;
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwdata_i=='hffffffff;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});
			finish_item(req);en_1;
			
			
		endtask
endclass


//========================= half duplex

class half_duplex	extends host_sequence;


		`uvm_object_utils(half_duplex)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="half_duplex");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
			finish_item(req);en_1;
		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;});
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwdata_i==2;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				assert(req.randomize with{paddr_i==addr;/*length_control==random;*/pwdata_i==2030;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		
			addr=1024;

		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});
			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
			finish_item(req);en_1;
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;});
			finish_item(req);en_1;

			
		endtask
endclass

//========================= full duplex

class full_duplex	extends host_sequence;


		`uvm_object_utils(full_duplex)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="full_duplex");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{penable_i==0;paddr_i=='h30;});
			finish_item(req);en_1;
		
		
		
			start_item(req);
				assert(req.randomize with{penable_i==0;paddr_i=='h30;pwrite_i==0;});
			finish_item(req);en_1;


		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
			finish_item(req);en_1;
	


			start_item(req);
				assert(req.randomize with{penable_i==0;paddr_i=='h40;pwrite_i==0;});
			finish_item(req);en_1;

	
			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
			finish_item(req);en_1;



			start_item(req);
				assert(req.randomize with{penable_i==0;paddr_i=='h44;pwrite_i==0;});
			finish_item(req);en_1;



	
		//---------  TX BD Num	

			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwdata_i==2;});
			finish_item(req);en_1;

		



			start_item(req);
				assert(req.randomize with{penable_i==0;paddr_i=='h20;pwrite_i==0;});
			finish_item(req);en_1;

		
		
		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==l46;});
			finish_item(req);en_1;


		
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;});
			finish_item(req);en_1;

           	 addr=addr+4;
			end		
			addr=1024;

		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
			finish_item(req);en_1;
	
	
			start_item(req);
				assert(req.randomize with{penable_i==0;paddr_i=='h08;pwrite_i==0;});
			finish_item(req);en_1;

		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{penable_i==0;paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwdata_i==32'h0000_c446 ;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{penable_i==0;paddr_i=='h0;pwrite_i==0;});
			finish_item(req);en_1;


			
		endtask
endclass


//========================= rxen_1 & half duplex

class rxen_1	extends host_sequence;


		`uvm_object_utils(rxen_1)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="rxen_1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==50;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;pwdata_i[31:16]==50;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		
			addr=1024;

		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});
			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwdata_i==32'h0000_c045 ;});		//fulld=0,rxen=1,txen=0
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;});
			finish_item(req);en_1;

			
		endtask
endclass



//========================= txen0 
class txen_0	extends host_sequence;


		`uvm_object_utils(txen_0)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="txen_0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==50;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;pwdata_i[31:16]==50;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		
			addr=1024;

		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});
			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwdata_i==32'h0000_c044;});		//fulld=0,rxen=0,txen=0
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;});
			finish_item(req);en_1;

			
		endtask
endclass


//========================= rxen_1,rxen1 & half duplex

class txen1_rxen1_fulld0	extends host_sequence;


		`uvm_object_utils(txen1_rxen1_fulld0)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="txen1_rxen1_fulld0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==random;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		
			addr=1024;

		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});
			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwdata_i==32'h0000_c047;});		//fulld=0,rxen=1,txen=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;});
			finish_item(req);en_1;

			
		endtask
endclass

//========================= rxen_1,rxen1 & full duplex

class txen1_rxen1_fulld1	extends host_sequence;


		`uvm_object_utils(txen1_rxen1_fulld1)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="txen1_rxen1_fulld1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==random;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		
			addr=1024;

		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});
			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwdata_i==32'h0000_c447;});		//fulld=1,rxen=1,txen=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;});
			finish_item(req);en_1;

			
		endtask
endclass



//=================================== txbd num 0

class tx_bd_num0	extends host_sequence;


		`uvm_object_utils(tx_bd_num0)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="tx_bd_num0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			start_item(req);
				assert(req.randomize with{prstn_i==1;psel_i==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;});
			finish_item(req);en_1;
	
		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==50;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;pwdata_i[31:16]==50;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		
			addr=1024;

		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		endtask
endclass


//==========================================  rd zero

	class rd0	extends	host_sequence;
			bit temp;
	

		`uvm_object_utils(rd0)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="rd0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;
		

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			start_item(req);
				assert(req.randomize with{prstn_i==1;psel_i==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//--------	BD Configuration	
			for(int i=0;i<  h_ethernet_config_class.TX_BD_NUM.TXBD*2 ; i++ ) begin		//{
			
			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==random;pwdata_i[15]==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		//}


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		endtask
endclass



//---------------------------------------------------- configure 128 bd's rd to 0

	class all_bd_rd0	extends	host_sequence;
			bit temp;
	

		`uvm_object_utils(all_bd_rd0)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="all_bd_rd0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;
		

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			start_item(req);
				assert(req.randomize with{prstn_i==1;psel_i==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==128;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//--------	BD Configuration	
			for(int i=0;i<  h_ethernet_config_class.TX_BD_NUM.TXBD*2 ; i++ ) begin		//{

			
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==50;pwdata_i[15]==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		//}


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		endtask
endclass


//---------------------------------------------------- configure 128 bd's rd to 1

	class all_bd_rd1	extends	host_sequence;
			bit temp;
	

		`uvm_object_utils(all_bd_rd1)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="all_bd_rd1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;
		

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			start_item(req);
				assert(req.randomize with{prstn_i==1;psel_i==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;pwdata_i==128;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//--------	BD Configuration	
			for(int i=0;i< (h_ethernet_config_class.TX_BD_NUM.TXBD*2) ; i++ ) begin		//{

			
			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==l46;pwdata_i[15:14]==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		//}


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		endtask
endclass

//---------------------------------------------------- configure 128 bd's rd to 0

	class config_all	extends	host_sequence;
			bit temp;
	

		`uvm_object_utils(config_all)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="config_all");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;
		

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			start_item(req);
				assert(req.randomize with{prstn_i==1;psel_i==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==128;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//--------	BD Configuration	
			for(int i=0;i<  h_ethernet_config_class.TX_BD_NUM.TXBD*2 ; i++ ) begin		//{

			
			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==random;});
			finish_item(req);en_1;

           	 addr=addr+4;
			end		//}


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		endtask
endclass


//---------------------------------------------------- rd0_rd1

	class rd0_rd1	extends	host_sequence;
			bit temp;
	
		`uvm_object_utils(rd0_rd1)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="rd0_rd1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;
		

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			start_item(req);
				assert(req.randomize with{prstn_i==1;psel_i==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==2;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//--------	BD Configuration	
			for(int i=0;i<  h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin		//{

			if(i%2==0)temp=0;	else temp=1;
			
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==50;pwdata_i[15]==temp;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		//}


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;



			
		endtask
endclass



//---------------------------------------------------- all bd's rd_101010...

	class all_bd_rd_1010	extends	host_sequence;
			bit temp;
	
		`uvm_object_utils(all_bd_rd_1010)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="all_bd_rd_1010");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;
		

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			start_item(req);
				assert(req.randomize with{prstn_i==1;psel_i==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;pwdata_i==128;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//--------	BD Configuration	
			for(int i=0;i<  h_ethernet_config_class.TX_BD_NUM.TXBD*2 ; i++ ) begin		//{

			if((i/2)%2==0)temp=1;
			else temp=0;
			
			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==random;pwdata_i[15]==temp;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		//}


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;



			
		endtask
endclass

//---------------------------------------------------- all bd's rd_0101010...

	class all_bd_rd_0101	extends	host_sequence;
			bit temp;
	
		`uvm_object_utils(all_bd_rd_0101)				//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="all_bd_rd_0101");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;
		

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					



			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			start_item(req);
				assert(req.randomize with{prstn_i==1;psel_i==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;prstn_i==1;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;pwdata_i==128;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//--------	BD Configuration	
			for(int i=0;i<  2*h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin		//{

			if((i/2)%2==0)temp=0;else temp=1;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==random;pwdata_i[15]==temp;});
			finish_item(req);en_1;

           	 addr=addr+4;
			end		//}


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;



			
		endtask
endclass


//-------------------------------------------------sequence for length > 46 with irq=1-------------------------------------------------------------------------------

class len_g46_condition_irq1 extends host_sequence;


		`uvm_object_utils(len_g46_condition_irq1)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g46_condition_irq1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	

		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet; });
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


		//--------	BD Configuration	


			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==l1500; pwdata_i[15:14]==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		



		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;
		


		endtask


endclass



/*
//==================================================== sudden reset


class sudden_reset extends host_sequence;


		`uvm_object_utils(sudden_reset)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="sudden_reset");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	

		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


		//--------	BD Configuration	

			req.length_control = req.l1500;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==l1500; pwdata_i[15:14]==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			#5000;

			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
		
		endtask


endclass

*/
//-------------------------------------------------sequence for length > 46 with irq=0-------------------------------------------------------------------------------
class len_g46_condition_irq0 extends host_sequence;


		`uvm_object_utils(len_g46_condition_irq0)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g46_condition_irq0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==1;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;});

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			req.length_control = req.l1500;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			start_item(req);
				assert(req.randomize with{paddr_i==addr; pwdata_i[15:14]==2;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i==addr;pwrite_i==0;};

			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;



		endtask


endclass



//-------------------------------------------------sequence for length > 46 with irq=1,txe_m=0,tx_b_m=0---------------------------------------------------------------

class len_g46_irq1_with_masking extends host_sequence;


		`uvm_object_utils(len_g46_irq1_with_masking)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g46_irq1_with_masking");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h40;pwrite_i==0;};

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h44;pwrite_i==0;};

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;
	
		//--------	BD Configuration	

	//		req.length_control = req.l1500;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				req.randomize with{paddr_i==addr;/*data==good_packet;*/pwdata_i[31:16]==49; pwdata_i[15:14]==3;};
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08; pwdata_i[1:0]==2'd0;};//masking txb,txe
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;



		endtask


endclass




//-------------------------------------------------sequence for length > 1500 with irq=1 , hugen=0---------------------------------------------------------------

class len_g1500_irq1_with_hugen0 extends host_sequence;


		`uvm_object_utils(len_g1500_irq1_with_hugen0)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g1500_irq1_with_hugen0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;pwdata_i==3;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
	
		//--------	BD Configuration	

			

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			start_item(req);
				req.randomize with{paddr_i==addr;length_control == l2030; pwdata_i[15:14]==3;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08; };
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;pwdata_i==bad_packet;};//req.pwdata_i[14]==0;};//hugen is 0 for bad packet
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;



		endtask


endclass



//-------------------------------------------------sequence for length > 1500 with irq=0 , hugen=0---------------------------------------------------------------

class len_g1500_irq0_with_hugen0 extends host_sequence;


		`uvm_object_utils(len_g1500_irq0_with_hugen0)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g1500_irq0_with_hugen0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h40;pwrite_i==0;};

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h44;pwrite_i==0;};

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			req.length_control = req.l2030;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			start_item(req);
				req.randomize with{paddr_i==addr;pwdata_i[15:14]==2;};//RD=1 AND IR=0
			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08; };
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;data==bad_packet;};//req.pwdata_i[14]==0;};//hugen is 0 for bad packet
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;

			#500;
			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		endtask


endclass


//-------------------------------------------------sequence for length > 1500 with irq=1,txb_m=0 txb_e=0 hugen=0----------------------------------------------------

class len_g1500_irq1_with_hugen0_masking extends host_sequence;


		`uvm_object_utils(len_g1500_irq1_with_hugen0_masking)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g1500_irq1_with_hugen0_masking");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h40;pwrite_i==0;};

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h44;pwrite_i==0;};

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			req.length_control = req.l2030;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;};//RD=1 AND IR=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i==addr;pwrite_i==0;};

			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08; req.pwdata_i[1:0]==0;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;data==bad_packet;};//req.pwdata_i[14]==0;};//hugen is 0 for bad packet
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;



		endtask


endclass


//-------------------------------------------------sequence for length > 1500 with irq=1 , hugen=1---------------------------------------------------------------

class len_g1500_irq1_with_hugen1 extends host_sequence;


		`uvm_object_utils(len_g1500_irq1_with_hugen1)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g1500_irq1_with_hugen1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h40;pwrite_i==0;};

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h44;pwrite_i==0;};

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;/*data==good_packet;*/pwdata_i==1; };
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			req.length_control = req.l2030;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;};//RD=1 AND IR=0
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i==addr;pwrite_i==0;};

			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08; };
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;};//hugen is 1 for good packet
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;



		endtask


endclass


//---------------------------len>4 with pad=1 irq=1 -------------------------------------------------------------------------------------------------------
class len_g4_irq1_with_pad1 extends host_sequence;


		`uvm_object_utils(len_g4_irq1_with_pad1)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g4_irq1_with_pad1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h40;pwrite_i==0;};

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h44;pwrite_i==0;};

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			//req.length_control = req.l46;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				req.randomize with{paddr_i==addr;length_control==req.l46;pwdata_i[15:14]==3;};//RD=1 AND IR=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08;pwdata_i==3; };
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;};//pad=1 ifg = 1 for good packet
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;



		endtask


endclass


//---------------------------len>4 with pad=1 irq=1 txe masking-------------------------------------------------------------------------------------------------------
class len_g4_irq1_with_pad1_txe_mask extends host_sequence;


		`uvm_object_utils(len_g4_irq1_with_pad1_txe_mask)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g4_irq1_with_pad1_txe_mask");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h40;pwrite_i==0;};

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h44;pwrite_i==0;};

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			req.length_control = req.l46;//4<length <46 

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;};//RD=1 AND IR=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i==addr;pwrite_i==0;};

			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08; req.pwdata_i[1:0]==1;};//txe mask
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;



		endtask


endclass



//---------------------------len>4 with pad=1 irq=1 txb masking-------------------------------------------------------------------------------------------------------
class len_g4_irq1_with_pad1_txb_mask extends host_sequence;


		`uvm_object_utils(len_g4_irq1_with_pad1_txb_mask)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g4_irq1_with_pad1_txb_mask");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h40;pwrite_i==0;};

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h44;pwrite_i==0;};

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			req.length_control = req.l46;//4<length <46 

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;};//RD=1 AND IR=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i==addr;pwrite_i==0;};

			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08; req.pwdata_i[1:0]==2;};//txb mask
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;



		endtask


endclass



//---------------------------len>4 with pad=1 irq=1 with masking------------------------------------------------------------------------------------------------------
class len_g4_irq1_with_pad1_with_mask extends host_sequence;


		`uvm_object_utils(len_g4_irq1_with_pad1_with_mask)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g4_irq1_with_pad1_with_mask");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h40;pwrite_i==0;};

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h44;pwrite_i==0;};

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			req.length_control = req.l46;//4<length <46 

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;};//RD=1 AND IR=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i==addr;pwrite_i==0;};

			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08; req.pwdata_i[1:0]==0;};//txb txe mask
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;



		endtask


endclass



//---------------------------len>4 with pad=1 irq=0-----------------------------------------------------------------------------------------------------
class len_g4_irq0_with_pad1 extends host_sequence;


		`uvm_object_utils(len_g4_irq0_with_pad1)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g4_irq0_with_pad1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h40;pwrite_i==0;};

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h44;pwrite_i==0;};

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;pwdata_i==3;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			req.length_control = req.l46;//4<length <46 

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				req.randomize with{paddr_i==addr; pwdata_i[15:14]==2;};//RD=1 AND IR=0
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i==addr;pwrite_i==0;};

			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08; };
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};			//int source read

			finish_item(req);en_1;
			

		endtask


endclass


//---------------------------len>4 with pad=0 irq=1-----------------------------------------------------------------------------------------------------
class len_g4_irq1_with_pad0 extends host_sequence;


		`uvm_object_utils(len_g4_irq1_with_pad0)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g4_irq1_with_pad0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h40;pwrite_i==0;};

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h44;pwrite_i==0;};

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			req.length_control = req.l46;//4<length <46 

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin

			start_item(req);
				req.randomize with{paddr_i==addr; pwdata_i[15:14]==2;};//RD=1 AND IRq=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i==addr;pwrite_i==0;};

			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08; };
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;data==bad_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;



		endtask


endclass


//------------------nopre_low_irq_high condition------------------------------------------------------------------------------
class nopre_low_irq_high extends host_sequence;


		`uvm_object_utils(nopre_low_irq_high)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="nopre_low_irq_high");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				req.randomize with{prstn_i==0;psel_i==0;};
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				req.randomize with{paddr_i=='h30;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			start_item(req);
				req.randomize with{paddr_i=='h30;pwrite_i==0;};
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
	
		//--------- source address	mac-0
			start_item(req);
				req.randomize with{paddr_i=='h40;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				req.randomize with{paddr_i=='h40;pwrite_i==0;};

			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				req.randomize with{paddr_i=='h44;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h44;pwrite_i==0;};

			finish_item(req);en_1;

	
		//---------  TX BD Num	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			req.length_control = req.l1500;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;};
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i==addr;pwrite_i==0;};

			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				req.randomize with{paddr_i=='h08;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				req.randomize with{paddr_i=='h08;pwrite_i==0;};

			finish_item(req);en_1;


		//---------	 INT_SOURCE

			start_item(req);
				req.randomize with{paddr_i=='h04;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				req.randomize with{paddr_i=='h04;pwrite_i==0;};

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				req.randomize with{paddr_i=='h0;req.pwdata_i==32'h0000_c046;};
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;};

			finish_item(req);en_1;



		endtask


endclass
















//==================================================================================================================================================================
//																			FUNC ERRORS
//==================================================================================================================================================================


//-------------------------------------------------sequence for length < 4  irq=1-------------------------------------------------------------------------------

class len_l4_rq1 extends host_sequence;


		`uvm_object_utils(len_l4_rq1)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_l4_rq1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					


			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;



			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;
	
		//--------	BD Configuration	


			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr; length_control==l4;pwdata_i[15:14]==3;});//irq=1 rd=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==3;});//masking
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});//masking

			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;req.pwdata_i[2]==0;});//nopre=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h4;pwrite_i==0;});

			finish_item(req);en_1;



		endtask


endclass




///////////////////////////////////len_g_2030_with_irq/////////////////////////////////////////////////////////////
class len_g_2030_with_irq extends host_sequence;


		`uvm_object_utils(len_g_2030_with_irq)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g_2030_with_irq");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;



			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;
	
		//--------	BD Configuration	


			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==46; /*length_control==g2030;*/pwdata_i[15:14]==3;});//irq=1 rd=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==3;});//masking
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});//masking

			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;req.pwdata_i[2]==0;});//nopre=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h4;pwrite_i==0;});

			finish_item(req);en_1;
			

		endtask


endclass



//-------------------------------------------------sequence for length < 4  irq=1-------------------------------------------------------------------------------

class len_l4_irq1_txbm0 extends host_sequence;


		`uvm_object_utils(len_l4_irq1_txbm0)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_l4_irq1_txbm0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	

		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwdata_i==5;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==l4; pwdata_i[15:14]==3;});	//length lessthan 4, inq=1, rd=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==1;});	//txb_m=0 txe_m=1 txb is masked
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;


		endtask


endclass

//-------------------------------------------------------
///////////////////////////////////len_l4_irq1/////////////////////////////////////////////////////////////
class len_l4_irq1 extends host_sequence;


		`uvm_object_utils(len_l4_irq1)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_l4_irq1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);
			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		
			
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;



			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;
	
		//--------	BD Configuration	

			req.length_control = req.l4;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);en_1;
				assert(req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;});//irq=1 rd=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==3;});//masking
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});//masking

			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		

		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;req.pwdata_i[2]==0;});//nopre=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;

			

		endtask


endclass


//-------------------------------------------------sequence for length < 4  irq=1	txem=0	-------------------------------------------------------------------

class len_l4_irq1_txem0 extends host_sequence;


		`uvm_object_utils(len_l4_irq1_txem0)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_l4_irq1_txem0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;
			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
	

		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwdata_i==5;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			start_item(req);
				assert(req.randomize with{paddr_i==addr;length_control==l4; pwdata_i[15:14]==3;});	//length lessthan 4, inq=1, rd=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==2;});	//txb_m=1 txe_m=0 txb is masked
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;


		endtask


endclass



//-------------------------------------------------sequence for length > 1500 with irq=0 , hugen=1---------------------------------------------------------------

class len_g1500_irq0_with_hugen1 extends host_sequence;


		`uvm_object_utils(len_g1500_irq0_with_hugen1)//factory registration
	
		ethernet_config_class	h_config;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g1500_irq0_with_hugen1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"ethernet_config_class",h_config)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				h_config.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwrite_i==0;});
			//	h_config.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				h_config.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});

			finish_item(req);en_1;
			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				h_config.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});

			finish_item(req);en_1;
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				h_config.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	

			req.length_control = req.l2030;

			for(int i=0;i< 2 * h_config.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr; pwdata_i[15:14]==2;}); //RD=1 AND IR=0
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				h_config.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;});

			finish_item(req);en_1;
           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;req.pwdata_i[1:0]==3; });
				h_config.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});

			finish_item(req);en_1;

		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				h_config.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;
		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});//hugen is 1 for good packet
				h_config.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;});

			finish_item(req);en_1;


		endtask


endclass




//------------------nopre_low_irq_low condition------------------------------------------------------------------------------
class nopre_low_irq_low extends host_sequence;


		`uvm_object_utils(nopre_low_irq_low)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="nopre_low_irq_low");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});

			finish_item(req);en_1;
			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});

			finish_item(req);en_1;
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	

			req.length_control = req.l1500;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr; req.pwdata_i[31:16]==46; pwdata_i[15:14]==2;});//irq=0
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;});

			finish_item(req);en_1;
           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});

			finish_item(req);en_1;

		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;
		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;req.pwdata_i[2]==0;});//nopre=0
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;


		endtask


endclass



//---------------------------------config_regs_while_transmitting------------------------------------------------------------------------------

class config_regs_while_transmitting extends host_sequence;


		`uvm_object_utils(config_regs_while_transmitting)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="config_regs_while_transmitting");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	

		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==1;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//--------	BD Configuration	

			req.length_control = req.l1500;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			start_item(req);
				assert(req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//-------------------------------reconfiguration while transmission---------------------------------
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	

		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==1;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		endtask


endclass

//-------------------------------------------------sequence for length > 1500 with irq=1 , hugen=1  masking---------------------------------------------------------------

class len_g1500_irq0_with_hugen1_mask extends host_sequence;


		`uvm_object_utils(len_g1500_irq0_with_hugen1)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g1500_irq0_with_hugen1");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});

			finish_item(req);en_1;
			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});

			finish_item(req);en_1;
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	

			req.length_control = req.l2030;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr; pwdata_i[15:14]==2;});//RD=1 AND IR=0
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;});

			finish_item(req);en_1;
           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;req.pwdata_i[1:0]==0;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});

			finish_item(req);en_1;

		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;
		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});//hugen is 1 for good packet
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;});

			finish_item(req);en_1;


		endtask


endclass



//------------------nopre_high_irq_mask condition------------------------------------------------------------------------------
class nopre_high_irq_mask extends host_sequence;


		`uvm_object_utils(nopre_high_irq_mask)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="nopre_high_irq_mask");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
			
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			
	
		//--------	BD Configuration	

			//req.length_control = req.l1500;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr; req.pwdata_i[31:16]==46; pwdata_i[15:14]==3;});//irq=1 rd=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==0;});//masking
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
			


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;
		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;req.pwdata_i[2]==1;});//nopre=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		


		endtask


endclass





///////////////////////////////////////////////len_g_1500_with_irq_mask_hugen_high///////////////////////////////////////////////////////////////

class len_g_1500_with_irq_mask_hugen_high extends host_sequence;


		`uvm_object_utils(len_g_1500_with_irq_mask_hugen_high)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g_1500_with_irq_mask_hugen_high");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});

			finish_item(req);en_1;
			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});

			finish_item(req);en_1;
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	

			req.length_control = req.l2030;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;});//RD=1 AND IRq=1				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwrite_i==0;});

			finish_item(req);en_1;
           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;req.pwdata_i[1:0]==2;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});

			finish_item(req);en_1;

		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;
		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});//hugen is 1 for good packet
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;pwrite_i==0;});

			finish_item(req);en_1;


		endtask


endclass

///////////////////////////////////////////////////////////////////len_g_2030_with_irq_txe_masked//////////////////////////////////////////////////

class len_g_2030_with_irq_txe_masked extends host_sequence;


		`uvm_object_utils(len_g_2030_with_irq_txe_masked)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g_2030_with_irq_txe_masked");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});

			finish_item(req);en_1;
			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});

			finish_item(req);en_1;
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	

			req.length_control = req.g2030;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;});//irq=1 rd=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);en_1;
           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==1;});//masking
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});//masking

			finish_item(req);en_1;		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;
		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;req.pwdata_i[2]==1;});//nopre=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});//masking

			finish_item(req);en_1;			


		endtask


endclass



///////////////////////////////////len_g_2030_with_irq_txb_mask/////////////////////////////////////////////////////////////
class len_g_2030_with_irq_txb_mask extends host_sequence;


		`uvm_object_utils(len_g_2030_with_irq_txb_mask)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g_2030_with_irq_txb_mask");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);
			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);
		
		
			
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);



			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);

			
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==2;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);
	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);
	
		//--------	BD Configuration	

			req.length_control = req.g2030;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;});//irq=1 rd=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);

			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);

           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==2;});//masking
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});//masking

			finish_item(req);
		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;req.pwdata_i[2]==0;});//nopre=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});//masking

			finish_item(req);
			

		endtask


endclass

////////////////////////////////////////////////////len_g_2030_with_irq_txe_txb_masked/////////////////////////////////////////////////////////////////


class len_g_2030_with_irq_txe_txb_masked extends host_sequence;


		`uvm_object_utils(len_g_2030_with_irq_txe_txb_masked)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_g_2030_with_irq_txe_txb_masked");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;pwrite_i==0;});
			//	//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

			start_item(req);
				assert(req.randomize with{paddr_i=='h40;pwrite_i==0;});

			finish_item(req);en_1;
			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;pwrite_i==0;});

			finish_item(req);en_1;
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	

			req.length_control = req.g2030;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;});//irq=1 rd=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);en_1;
           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==0;});//masking
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});//masking

			finish_item(req);en_1;		


		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;
		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;req.pwdata_i[2]==1;});//nopre=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});//masking

			finish_item(req);en_1;			
		endtask
endclass

/////////////////////////////////////////////////////////////////MTxERR_CHECK//////////////////////////////////////////////////////////////////////////////////
class MTxERR_CHECK extends host_sequence;


		`uvm_object_utils(MTxERR_CHECK)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="MTxERR_CHECK");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	

		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;pwdata_i==1;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//--------	BD Configuration	

			//req.length_control = req.l1500;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			start_item(req);
				assert(req.randomize with{paddr_i==addr; pwdata_i[31:16]==100; pwdata_i[15:14]==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
           	 addr=addr+4;
			end		
		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i==3;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{pwrite_i==0;});

			finish_item(req);en_1;
		endtask
endclass
///////////////////////////len_l4_irq1_txem0_txbm0///////////////////////////////////////////////////
class len_l4_irq1_txem0_txbm0 extends host_sequence;


		`uvm_object_utils(len_l4_irq1_txem0_txbm0)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;

		int 		addr=1024;
	//===================================== object construction ===================================//

		function  new(string name="len_l4_irq1_txem0_txbm0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	

			req.length_control = req.l4;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr; pwdata_i[15:14]==3;});//irq=1 rd=1
				//$display($time,"in host sequence %0d",req.pwdata_i[31:16]);
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);en_1;
           	 addr=addr+4;
			end		
		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==0;});//masking
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});//masking

			finish_item(req);en_1;		
	//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;req.pwdata_i[2]==0;});//nopre=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;
		
		//---------	 INT_SOURCE
			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;	

		endtask
endclass
/////////////////////////////////////////////////len_l4_irq0//////////////////////////////////////////////////////////


class len_l4_irq0 extends host_sequence;


		`uvm_object_utils(len_l4_irq0)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;		
		

	//===================================== object construction ===================================//

		function  new(string name="len_l4_irq0");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");
		

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;

		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	
		req.length_control = req.l4;

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr; pwdata_i[15:14]==2;});//irq=1 rd=1
				
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);en_1;
           	 addr=addr+4;
			end		
		//---------	 INT_MASK
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==3;});//masking
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});//masking

			finish_item(req);en_1;		
	//---------	Moder
			start_item(req);
				assert(req.randomize with{paddr_i=='h0;req.pwdata_i[2]==0;});//nopre=1
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;
		
		//---------	 INT_SOURCE
			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;	

		endtask
endclass

/////////////////////////////////////////////////len_l4//////////////////////////////////////////////////////////


class len4 extends host_sequence;


		`uvm_object_utils(len4)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;		
		

	//===================================== object construction ===================================//

		function  new(string name="len4");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");
		

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	
			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==4; pwdata_i[15:14]==3;});//irq=1 rd=1
				
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);en_1;
           	 addr=addr+4;
			end		
		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==3;});// no masking
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});// no masking
			finish_item(req);en_1;		

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});//nopre=1
			finish_item(req);en_1;			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;
		
		//---------	 INT_SOURCE
			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;	

		endtask
endclass

/////////////////////////////////////////////////len_5//////////////////////////////////////////////////////////


class len5 extends host_sequence;


		`uvm_object_utils(len5)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;		
		

	//===================================== object construction ===================================//

		function  new(string name="len5");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");
		

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==8; pwdata_i[15:14]==3;});//irq=1 rd=1
				
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);en_1;
           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==3;});// no masking
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});// no masking
			finish_item(req);en_1;		


		

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});//nopre=1
			finish_item(req);en_1;			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;
		
		//---------	 INT_SOURCE

			

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;	

		endtask

endclass


/////////////////////////////////////////////////len_46 nopad//////////////////////////////////////////////////////////


class len_46_pad0_corner extends host_sequence;


		`uvm_object_utils(len_46_pad0_corner)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;		
		

	//===================================== object construction ===================================//

		function  new(string name="len_46_pad0_corner");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");
		

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
			
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	


			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==46; pwdata_i[15:14]==3;});//irq=1 rd=1
				
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);en_1;
           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==3;});// no masking
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});// no masking
			finish_item(req);en_1;		
		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwdata_i=='h0000_0042;});//pad=0
			finish_item(req);en_1;			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;
		
		//---------	 INT_SOURCE

			

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;	

		endtask
endclass

/////////////////////////////////////////////////len_46 pad//////////////////////////////////////////////////////////


class len_46_pad1_corner extends host_sequence;


		`uvm_object_utils(len_46_pad1_corner)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;		
		

	//===================================== object construction ===================================//

		function  new(string name="len_46_pad1_corner");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");
		

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	


			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==48; pwdata_i[15:14]==3;});//irq=1 rd=1
				
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);en_1;
           	 addr=addr+4;
			end		

		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==3;});// no masking
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});// no masking
			finish_item(req);en_1;		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;data==good_packet;});//pad=1
			finish_item(req);en_1;			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;
		
		//---------	 INT_SOURCE

			

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;	

		endtask

endclass
/////////////////////////////////////////////////len_1500_hugen0_corner//////////////////////////////////////////////////////////


class len_1500_hugen0_corner extends host_sequence;


		`uvm_object_utils(len_1500_hugen0_corner)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;		
		

	//===================================== object construction ===================================//

		function  new(string name="len_1500_hugen0_corner");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");
		

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	

			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==1510; pwdata_i[15:14]==3;});//irq=1 rd=1			
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);en_1;
           	 addr=addr+4;
			end		
		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==3;});// no masking
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});// no masking
			finish_item(req);en_1;		


		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwdata_i=='h0000_0042;});//pad=1  hugen=0
			finish_item(req);en_1;			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});
			finish_item(req);en_1;
		
		//---------	 INT_SOURCE
		

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});
			finish_item(req);en_1;	

		endtask
endclass
/////////////////////////////////////////////////len_1500_hugen1_corner//////////////////////////////////////////////////////////


class len_1500_hugen1_corner extends host_sequence;


		`uvm_object_utils(len_1500_hugen1_corner)//factory registration
	
		ethernet_config_class	h_ethernet_config_class;		
		

	//===================================== object construction ===================================//

		function  new(string name="len_1500_hugen1_corner");
			super.new(name);

		endfunction
	
	//=================================== RUN PHASE =======================================//

		task body;

				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN HOST SEQUENCE");
		

			req=ethernet_sequence_item::type_id::create("req");					

			//---------------rst check----------------------------	
			start_item(req);
				assert(req.randomize with{prstn_i==0;psel_i==0;});
			finish_item(req);en_1;			
			
		//----------  destination address
			start_item(req);
				assert(req.randomize with{paddr_i=='h30;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;		
		
	
		//--------- source address	mac-0
			start_item(req);
				assert(req.randomize with{paddr_i=='h40;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;


			
		//--------- source address	mac-1
			start_item(req);
				assert(req.randomize with{paddr_i=='h44;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;
			
	
		//---------  TX BD Num	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;data==good_packet;});
				//h_ethernet_config_class.run(req.paddr_i,req.pwdata_i);
			finish_item(req);en_1;	
			start_item(req);
				assert(req.randomize with{paddr_i=='h20;pwrite_i==0;});

			finish_item(req);en_1;	
		//--------	BD Configuration	


			for(int i=0;i< 2 * h_ethernet_config_class.TX_BD_NUM.TXBD ; i++ ) begin
			//req.length_control = req.l1500;
			start_item(req);
				assert(req.randomize with{paddr_i==addr;pwdata_i[31:16]==1510; pwdata_i[15:14]==3;});//irq=1 rd=1
				
			finish_item(req);en_1;
			start_item(req);
				assert(req.randomize with{req.paddr_i==addr;req.pwrite_i==0;});//reading
				
			finish_item(req);en_1;
           	 addr=addr+4;
			end		


		//---------	 INT_MASK

			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwdata_i[1:0]==3;});// no masking
			finish_item(req);en_1;		
			start_item(req);
				assert(req.randomize with{paddr_i=='h08;pwrite_i==0;});// no masking
			finish_item(req);en_1;		

		//---------	Moder

			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwdata_i=='h0000_6042;});//pad=1  hugen=1
			finish_item(req);en_1;			start_item(req);
				assert(req.randomize with{paddr_i=='h0;pwrite_i==0;});

			finish_item(req);en_1;
		
		//---------	 INT_SOURCE

			start_item(req);
				assert(req.randomize with{paddr_i=='h04;pwrite_i==0;});

			finish_item(req);en_1;	

		endtask

endclass
