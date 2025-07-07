class coverage extends uvm_component;
	
	`uvm_component_utils(coverage)

	virtual	ethernet_interface	h_intf;
	


	covergroup covergrp;
	//=============GLOBAL SIGNALS=======================//
		preset:coverpoint h_intf.prstn_i{
											bins preset_0={0};
											bins preset_1={1};
											}

	//============= ADDRESS OF REGISTERS ===============//
		paddr_i:coverpoint h_intf.paddr_i iff(h_intf.prstn_i){
																bins MODER={32'h00};
																bins INT_SOURCE={'h04};
																bins INT_MASK={'h08};
																bins TX_BD_NUM={'h20};
																bins MII_ADDRESS={'h30};
																bins MAC_ADDR0={'h40};
																bins MAC_ADDR1={'h44};
          										//				bins TXD[256]={['h400:'h7ff]};		
															   }
      
      
      
      //====================MODER=========================================================================//
      
      eth_moder_rxen:coverpoint h_intf.pwdata_i[0] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
																	bins moder_rxen_0={0};
																	bins moder_rxen_1={1};
																	}            
   
      
      eth_moder_txen:coverpoint h_intf.pwdata_i[1] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
																	bins moder_txen_0={0};
																	bins moder_txen_1={1};
																	}      

      eth_moder_nopre:coverpoint h_intf.pwdata_i[2] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
																	bins nopre_0={0};
																	bins noopre_1={1};
																	}
      eth_moder_ifg:coverpoint h_intf.pwdata_i[6] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
																	bins moder_ifg_0={0};
																	bins moder_ifg_1={1};
																	}

      eth_moder_loopback:coverpoint h_intf.pwdata_i[7] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
																	bins moder_loopback_0={0};
																	bins moder_loopback_1={1};
																	}
      
      eth_moder_fulld:coverpoint h_intf.pwdata_i[10] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
																	bins moder_fulld_0={0};
																	bins moder_fulld_1={1};
																	}
      
      eth_moder_hugen:coverpoint h_intf.pwdata_i[14] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
																	bins moder_hugen_0={0};
																	bins moder_hugen_1={1};
																	}
      
      eth_moder_pad:coverpoint h_intf.pwdata_i[15] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
																	bins moder_pad_0={0};
																	bins moder_pad_1={1};
																	}
      
      
      
      
      
      //==================== INT_MASK =========================================================================//

      
      eth_int_mask_txb_m:coverpoint h_intf.pwdata_i[0] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h08){
																	bins int_mask_txb_0={0};
																	bins int_mask_txb_1={1};
																	}     
      
      eth_int_mask_txe_m:coverpoint h_intf.pwdata_i[1] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h08){
																	bins int_mask_txe_0={0};
																	bins int_mask_txe_1={1};
																	}                   
      
      

      //==================== TX_BD_NUM =========================================================================//
      
      
      eth_TX_BD_NUM_TXBD:coverpoint h_intf.pwdata_i[7:0] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h20){
																	bins int_mask_TX_BD_NUM_TXBD_0={0};
        															bins int_mask_TX_BD_NUM_TXBD_low={[1:20]};
        															bins int_mask_TX_BD_NUM_TXBD_mid={[21:40]};
        															bins int_mask_TX_BD_NUM_TXBD_medium={[41:70]};
        															bins int_mask_TX_BD_NUM_TXBD_high={[71:127]};
																	}
      
      
      //========================== TX_D =========================================================================//
      

      eth_TXD_len:coverpoint h_intf.pwdata_i[31:16] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i>='h400  && h_intf.paddr_i<='h7ff && h_intf.paddr_i%8==0){
																	bins TXD_len_0={0};
        															bins TXD_len_2to3={[2:3]};
        															bins TXD_len_4={4};
                                 									bins TXD_len_5to45={[5:45]};
                                  									bins TXD_len_46to1500={[46:1500]};
                                  									bins TXD_len_1500to2030={[1500:2030]};
        															bins TXD_len_g2030={[2031:$]};
																	}
      
      
      eth_TXD_irq:coverpoint h_intf.pwdata_i[14] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i>='h400  && h_intf.paddr_i<='h7ff && h_intf.paddr_i%8==0){
																	bins TXD_irq_0={0};
        															bins TXD_irq_1={1};
      														}
      

      

     //==================== TX_MAC =========================================================================//

      

      eth_TXMAC_MCrS:coverpoint h_intf.MCrS iff(h_intf.prstn_i){
																bins TXMAC_MCrS_0={0};
	        													bins TXMAC_MCrS_1={1};	

																	}
      
      
      
    
//_______________________________________________________________________________________________________________________________________________________________________________________ 


  
      
    //============================================================================================================//
    //******************************************** CROSS BINS ****************************************************//
    //============================================================================================================//
      
      //========================AUTO BINS============================//
      eth_cross_hugen_pad:cross eth_moder_hugen,eth_moder_pad;
      
      
        
      eth_cross_hugen_pad_txen:cross eth_moder_txen,eth_moder_hugen,eth_moder_pad{
        bins cross_PHTx_000	=  binsof(eth_moder_pad.moder_pad_0)&& binsof(eth_moder_hugen.moder_hugen_0) && binsof(eth_moder_txen.moder_txen_0) ;
        
      	bins cross_PHTx_001	=  binsof(eth_moder_pad.moder_pad_0)&& binsof(eth_moder_hugen.moder_hugen_0) && binsof(eth_moder_txen.moder_txen_1) ;
        
      	bins cross_PHTx_010	=  binsof(eth_moder_pad.moder_pad_0)&& binsof(eth_moder_hugen.moder_hugen_1) && binsof(eth_moder_txen.moder_txen_0) ;
      														     	
        bins cross_PHTx_011	=  binsof(eth_moder_pad.moder_pad_0)&& binsof(eth_moder_hugen.moder_hugen_1) && binsof(eth_moder_txen.moder_txen_1) ;
      
        bins cross_PHTx_100	=  binsof(eth_moder_pad.moder_pad_1)&& binsof(eth_moder_hugen.moder_hugen_0) && binsof(eth_moder_txen.moder_txen_0) ;
      
        bins cross_PHTx_101	=  binsof(eth_moder_pad.moder_pad_1)&& binsof(eth_moder_hugen.moder_hugen_0) && binsof(eth_moder_txen.moder_txen_1) ;
      
        bins cross_PHTx_110	=  binsof(eth_moder_pad.moder_pad_1)&& binsof(eth_moder_hugen.moder_hugen_1) && binsof(eth_moder_txen.moder_txen_0) ;
        
        bins cross_PHTx_111	=  binsof(eth_moder_pad.moder_pad_1)&& binsof(eth_moder_hugen.moder_hugen_1) && binsof(eth_moder_txen.moder_txen_1) ;
      }
      	

    //=======================INT_MASK CROSS ================================================//
    
    CROSS_eth_int_mask_txb_m_txe_m	:	cross eth_int_mask_txb_m,eth_int_mask_txe_m;
      
    
    //============= REGISTERS CHECK ================================================================//

    
 																	//}
      
      eth_moder_config:coverpoint h_intf.pwdata_i iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
        										bins moder_config_ffff={32'hffff_ffff};
        										bins moder_config_0000={32'd0};
      															}
 
      
      eth_int_source_config:coverpoint h_intf.pwdata_i iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h04){
        										bins int_source_config_ffff={32'hffff_ffff};
        										bins int_source_config_0000={32'd0};
      															}      
      
 
      eth_int_mask_config:coverpoint h_intf.pwdata_i iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h08){
        										bins int_mask_config_ffff={32'hffff_ffff};
        										bins int_mask_config_0000={32'd0};
      															}    
    
    
      eth_TX_BD_NUM_config:coverpoint h_intf.pwdata_i iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h20){
        										bins TX_BD_NUM_config_ffff={32'hffff_ffff};
        										bins TX_BD_NUM_config_0000={32'd0};
      															}        

      eth_MII_ADDRESS_config:coverpoint h_intf.pwdata_i iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h30){
        										bins MII_ADDRESS_config_ffff={32'hffff_ffff};
        										bins MII_ADDRESS_config_0000={32'd0};
      															}        
      eth_MAC_ADDR0_config:coverpoint h_intf.pwdata_i iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h40){
        										bins MAC_ADDR0_config_ffff={32'hffff_ffff};
        										bins MAC_ADDR0_config_0000={32'd0};
      															}      	
      eth_MAC_ADDR1_config:coverpoint h_intf.pwdata_i iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h44){
        										bins MAC_ADDR1_config_ffff={32'hffff_ffff};
        										bins MAC_ADDR1_config_0000={32'd0};
      															}      
   
    
//_______________________________________________________________________________________________________________________________________________________________________________________ 
        


     //============= TRANSITION BINS ================================================================//
     			eth_trans_TXD_rd:coverpointh_seqitem.pwdata_i[15]iff(h_intf.prstn_i&&h_intf.pwrite_i&&h_intf.paddr_i>='h400&&h_intf.paddr_i<='h7ff&&h_intf.paddr_i%8==0){
                                                                    bins TXD_rd_0_1= 64[=(0 => 1)];
                                                                    bins TXD_rd_1_0= 64[=(1 => 0)];
                                                                    bins TXD_rd_1_1= 64[=(1 => 1)];
      						
      }
        
      eth_trans_moder_rxen:coverpoint h_intf.pwdata_i[0] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
                                                                    bins moder_rxen_0_0=(0=>0);
                                                                    bins moder_rxen_0_1=(0=>1); 
                                                                    bins moder_rxen_1_0=(1=>0);
                                                                    bins moder_rxen_1_1=(1=>1);
																	}            
   
      
      eth_trans_moder_txen:coverpoint h_intf.pwdata_i[1] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
        															bins moder_txen_0_0=(0=>0);
                                                                    bins moder_txen_0_1=(0=>1);
                                                                    bins moder_txen_1_0=(1=>0);
                                                                    bins moder_txen_1_1=(1=>1);
       
																	}      

      eth_trans_moder_nopre:coverpoint h_intf.pwdata_i[2] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
                                                                    bins moder_nopre_0_0=(0=>0); 
                                                                    bins moder_nopre_0_1=(0=>1); 
                                                                    bins moder_nopre_1_0=(1=>0);
                                                                    bins moder_nopre_1_1=(1=>1);
																	}
      eth_trans_moder_ifg:coverpoint h_intf.pwdata_i[6] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
                                                                    bins moder_ifg_0_0=(0=>0);
                                                                    bins moder_ifg_0_1=(0=>1);         
                                                                    bins moder_ifg_1_0=(1=>0);
                                                                    bins moder_ifg_1_1=(1=>1);
																	}

      eth_trans_moder_loopback:coverpoint h_intf.pwdata_i[7] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
                                                                    bins moder_loopback_0_0=(0=>0);  
                                                                    bins moder_loopback_0_1=(0=>1); 
                                                                    bins moder_loopback_1_0=(1=>0);
                                                                    bins moder_loopback_1_1=(1=>1);
																	}
      
      eth_trans_moder_fulld:coverpoint h_intf.pwdata_i[10] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
                                                                    bins moder_fulld_0_0=(0=>0); 
                                                                    bins moder_fulld_0_1=(0=>1);
                                                                    bins moder_fulld_1_0=(1=>0);
                                                                    bins moder_fulld_1_1=(1=>1);
																	}
      
      eth_trans_moder_hugen:coverpoint h_intf.pwdata_i[14] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
                                                                    bins moder_hugen_0_0=(0=>0); 
                                                                    bins moder_hugen_0_1=(0=>1);
                                                                    bins moder_hugen_1_0=(1=>0);
                                                                    bins moder_hugen_1_1=(1=>1);
																	}
      
      eth_trans_moder_pad:coverpoint h_intf.pwdata_i[15] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h00){
                                                                    bins moder_pad_0_0=(0=>0);
                                                                    bins moder_pad_0_1=(0=>1);
                                                                    bins moder_pad_1_0=(1=>0);
                                                                    bins moder_pad_1_1=(1=>1);
																	}    
    
    
      
      //==================== INT_MASK =========================================================================//

      
      eth_trans_int_mask_txb_m:coverpoint h_intf.pwdata_i[0] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h08){
                                                                    bins int_mask_txb_0_0=(0=>0);
                                                                    bins int_mask_txb_0_1=(0=>1); 
                                                                    bins int_mask_txb_1_0=(1=>0); 
                                                                    bins int_mask_txb_1_1=(1=>1);
																	}     
      
      eth_trans_int_mask_txe_m:coverpoint h_intf.pwdata_i[1] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i=='h08){
                                                                    bins int_mask_txe_0_0=(0=>0); 
                                                                    bins int_mask_txe_0_1=(0=>1);
                                                                    bins int_mask_txe_1_0=(1=>0); 
                                                                    bins int_mask_txe_1_1=(1=>1);
																	}     
	
      
      //========================== TX_D =========================================================================//
      
      eth_trans_TXD_irq:coverpoint h_intf.pwdata_i[14] iff(h_intf.prstn_i && h_intf.pwrite_i && h_intf.paddr_i>='h400  && h_intf.paddr_i<='h7ff && h_intf.paddr_i%8==0){
                                                                    bins TXD_irq_0_0=(0=>0);
                                                                    bins TXD_irq_0_1=(0=>1);
                                                                    bins TXD_irq_1_0=(1=>0);
                                                                    bins TXD_irq_1_1=(1=>1);
      						}  
      
      
           //==================== TX_MAC =========================================================================//

            eth_trans_TXMAC_MCrS:coverpoint h_intf.MCrS iff(h_intf.prstn_i){
                                                                    bins TXMAC_MCrS_0_0=(0=>0);
                                                                    bins TXMAC_MCrS_0_1=(0=>1);
                                                                    bins TXMAC_MCrS_1_0=(1=>0);
                                                                    bins TXMAC_MCrS_1_1=(1=>1);
																	}
      
      
      
      
      
      
      
      
    


    
    endgroup



	//------------------------------ component construction	-----------------------//

		function	new(string name="",uvm_component parent);
			super.new(name ,parent);
			covergrp=new();
		endfunction


	
	//------------------------------- connect_phase -------------------------------//

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);

			assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))	else	$fatal("coverages hintf not getting");			
		endfunction



		task run_phase(uvm_phase phase);

		super.run_phase(phase);
		forever begin
			covergrp.sample();
		#20;
		end

		endtask

endclass
