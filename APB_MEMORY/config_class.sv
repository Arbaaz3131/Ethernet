
//===============================================================================================================================================//
//-----------------------------------------------------------------CONFIG CLASS------------------------------------------------------------------//
//===============================================================================================================================================//



class ethernet_config_class extends uvm_object;

	`uvm_object_utils(ethernet_config_class)
	
  struct { bit PAD,HUGEN,FULLD,LOOPBACK,IFG,NOPRE,TXEN,RXEN;}moder;
  struct { bit TXE,TXB;}int_source;
  struct { bit TXE_M,TXB_M;}int_mask; 
  struct { bit [7:0]TXBD;}TX_BD_NUM;
  struct { bit [31:0]MAC_ADDR1; bit [31:0]MAC_ADDR0;}SOURCE_ADDR;
  struct { bit [31:0]MII_ADDR;}DESTINATION_ADDR;
	//int TX_D[int];
	
	typedef struct {bit [15:0]LENGTH;bit IRQ,RD,TEMP_RD;}offset0;
	typedef struct {bit [31:0]POINTER;}offset4;
	offset0 TXD0[*];
	offset4 TXD1[*];
 
	bit 		pack;
	int			temp_length;

	task run(input bit	[31:0]paddr_i,pwdata_i);
    
		if(paddr_i=='h00)begin
     		 moder.PAD=pwdata_i[15];
      		 moder.HUGEN=pwdata_i[14];
     		 moder.FULLD=pwdata_i[10];
      		 moder.LOOPBACK=pwdata_i[7];
      		 moder.IFG=pwdata_i[6];
      		 moder.NOPRE=pwdata_i[2];
      		 moder.TXEN=pwdata_i[1];
      		 moder.RXEN=pwdata_i[0];
		$display($time,">>>>>>>>> MODER = %p",moder);
			 
    	end

    
		if(paddr_i=='h04)begin
	        int_source.TXE=pwdata_i[1];
        	int_source.TXB=pwdata_i[0];
		$display($time,">>>>>>>>> INT_SOURCE = %p",int_source);
			
    	end

		if(paddr_i=='h08)begin
      		int_mask.TXE_M=pwdata_i[1];
      		int_mask.TXB_M=pwdata_i[0];
		$display($time,">>>>>>>>> int_mask = %p",int_mask);

    	end

		
		if(paddr_i=='h20)begin
	     	TX_BD_NUM.TXBD=pwdata_i[7:0];

			$display($time," $$$$$ TX_BD_NUM =%p",TX_BD_NUM);
    	end

		if(paddr_i=='h30)begin
      		DESTINATION_ADDR.MII_ADDR=pwdata_i;
		$display($time,">>>>>>>>> destimation add = %p",DESTINATION_ADDR);

	    end


		if(paddr_i=='h40)begin
    	  SOURCE_ADDR.MAC_ADDR0=pwdata_i;
		$display($time,">>>>>>>>> source add0 = %h",SOURCE_ADDR.MAC_ADDR0);
	    end

		if(paddr_i=='h44)begin
    	  SOURCE_ADDR.MAC_ADDR1=pwdata_i;
		$display($time,">>>>>>>>> source add1 = %h",SOURCE_ADDR.MAC_ADDR1);
	    end


		if(paddr_i>='h400&&paddr_i<='h7ff&& paddr_i%8==0)begin
			TXD0[paddr_i].LENGTH=pwdata_i[31:16];
			TXD0[paddr_i].RD=pwdata_i[15];
			TXD0[paddr_i].TEMP_RD=pwdata_i[15];
			TXD0[paddr_i].IRQ=pwdata_i[14];
			$display($time,">>>>>>addr=%0d..txd0=%p",paddr_i,TXD0);
			
		end

		if(paddr_i>='h400&&paddr_i<='h7ff&& paddr_i%8==4	/*paddr_i*/)begin
			TXD1[paddr_i].POINTER=pwdata_i;
			$display($time,">>>>>>>>addr=%0d...txd1=%p",paddr_i,TXD1);
		end



/*
		if(paddr_i>='h400 && paddr_i<='h7ff)begin

			TX_D[paddr_i]=pwdata_i;
		end

*/

  endtask
  
  

	function new(string name="ethernet_config_class");
		super.new(name);
	endfunction




endclass
