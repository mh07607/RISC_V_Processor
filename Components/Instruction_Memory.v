module Instruction_Memory
(
	input [63:0] Inst_Address,
	output reg [31:0] Instruction
);
	reg [7:0] inst_mem [1023:0];
	
	initial
	begin
		inst_mem[0]=8'b00010011; //addi x12, x0, 1
		inst_mem[1]=8'b00000110;
		inst_mem[2]=8'b00010000;
		inst_mem[3]=8'b00000000;
		
		//loop1 
        inst_mem[4]=8'b01100011; //beq x12, x3, exit //2
        inst_mem[5]=8'b00001000; 
        inst_mem[6]=8'b00110110; 
        inst_mem[7]=8'b00000100;  
        
        //continue 
        inst_mem[8]=8'b10110011;  //add x13, x0, x12 //4
        inst_mem[9]=8'b00000110;  
        inst_mem[10]=8'b11000000;
        inst_mem[11]=8'b00000000;
         
        inst_mem[12]=8'b00010011; //slli x14, x13, 3*  (not sure if this will be needed) //5 
        inst_mem[13]=8'b10010111; 
        inst_mem[14]=8'b00110110;  
        inst_mem[15]=8'b00000000;
        
        inst_mem[16]=8'b00110011; //add x14, x14, x4 //6  
        inst_mem[17]=8'b00000111; 
        inst_mem[18]=8'b01000111; 
        inst_mem[19]=8'b00000000;
         
        inst_mem[20]=8'b10000011; //ld* x15, 0(x14) //7 
        inst_mem[21]=8'b00110111; 
        inst_mem[22]=8'b00000111; 
        inst_mem[23]=8'b00000000;
        
        inst_mem[24] = 8'b01100011; //beq x13, x0, end_loop2 //8
        inst_mem[25] = 8'b10001010;
        inst_mem[26] = 8'b00000110;
        inst_mem[27] = 8'b00000010;
        
        inst_mem[28] = 8'b00010011;      //addi x16, x13, -1 # (x16 = j - 1) //9  
        inst_mem[29] = 8'b10001000;
        inst_mem[30] = 8'b11110110;
        inst_mem[31] = 8'b11111111;
        
        inst_mem[32] = 8'b10010011; //slli x17, x16, 3* (not sure if this will be needed) //10
        inst_mem[33] = 8'b00011000;    
        inst_mem[34] = 8'b00101000;
        inst_mem[35] = 8'b00000000;
        
        inst_mem[36] = 8'b10110011;   //add x17, x17, x4  # add array base address //11
        inst_mem[37] = 8'b10001000;
        inst_mem[38] = 8'b01001000;
        inst_mem[39] = 8'b00000000;
        
        inst_mem[40] = 8'b00000011; //ld* x18, 0(x17)  # load A[j-1] //12
        inst_mem[41] = 8'b10111001;
        inst_mem[42] = 8'b00001000;
        inst_mem[43] = 8'b00000000;
         // loop2 //
//        00000010 00000110 10001010 01100011 //beq x13, x0, end_loop2 //8
//        11111111 11110110 10001000 00010011 //addi x16, x13, -1 # (x16 = j - 1) //9
//        00000000 00101000 00011000 10010011 //slli x17, x16, 3* (not sure if this will be needed) //10
//        00000000 01001000 10001000 10110011 //add x17, x17, x4  # add array base address //11
//        00000000 00001000 10111001 00000011 //ld* x18, 0(x17)  # load A[j-1] //12
        
        inst_mem[44]=8'b01100011; //blt x18, x15 end_loop2  # if A[j-1] < A[j], exit loop2 //13
		inst_mem[45]=8'b01000000; 
		inst_mem[46]=8'b11111001; 
		inst_mem[47]=8'b00000010; 
		
//        /00000001 00100111 00110000 00100011 //sd* x18, 0(x14)  # store A[j-1] at A[j] //14
//        /00000000 11111000 10110000 00100011 //sd* x15, 0(x17)  # store A[j] at A[j-1] //15
//        /11111111 11110110 10000110 10010011 //addi x13, x13, -1  # j = j - 1 //16
//        


        inst_mem[48] = 8'b00100011; //sd* x18, 0(x14)  # store A[j-1] at A[j] //14
        inst_mem[49] = 8'b00110000; 
        inst_mem[50] = 8'b00100111; 
        inst_mem[51] = 8'b00000001;
        
        inst_mem[52] = 8'b00100011;//sd* x15, 0(x17)  # store A[j] at A[j-1] //15
        inst_mem[53] = 8'b10110000;
        inst_mem[54] = 8'b11111000;
        inst_mem[55] = 8'b00000000;
        
        inst_mem[56] = 8'b10010011;   //addi x13, x13, -1  # j = j - 1 //16
        inst_mem[57] = 8'b10000110;
        inst_mem[58] = 8'b11110110; 
        inst_mem[59] = 8'b11111111;
        
        ///00000000 00110110 10010111 00010011 //slli x14, x13, 3*  # multiply by 4 to get offset //17
//        /00000000 01000111 00000111 00110011 //add x14, x14, x4 //18
//        /00000000 00000111 00110111 10000011 //ld* x15, 0(x14)  # load A[j] //19
//        /11111100 00000000 00001000 11100011 //beq x0, x0 loop2 //20
        
        inst_mem[60] = 8'b00010011; //slli x14, x13, 3*  # multiply by 4 to get offset //17
        inst_mem[61] = 8'b10010111;
        inst_mem[62] = 8'b00110110;
        inst_mem[63] = 8'b00000000;
        
        inst_mem[64] = 8'b00110011;  //add x14, x14, x4 //18
        inst_mem[65] = 8'b00000111;
        inst_mem[66] = 8'b01000111;
        inst_mem[67] = 8'b00000000;
                
		inst_mem[68] = 8'b10000011;  //ld* x15, 0(x14)  # load A[j] //19
		inst_mem[69] = 8'b00110111;
		inst_mem[70] = 8'b00000111;
		inst_mem[71] = 8'b00000000;
		
		inst_mem[72] = 8'b11100011; //beq x0, x0 loop2 //20
		inst_mem[73] = 8'b00001000;
        inst_mem[74] = 8'b00000000;
        inst_mem[75] = 8'b11111100;		
        
        //end_loop2
//        /00000000 00010110 00000110 00010011 //addi x12, x12, 1  # i = i + 1 //21
//        11111010 00000000 00001010 11100011 //beq x0, x0,loop1 //22
//        //exit 
//        //23
        
        inst_mem[76] = 8'b00010011;   //addi x12, x12, 1  # i = i + 1 //21
        inst_mem[77] = 8'b00000110;
        inst_mem[78] = 8'b00010110;
        inst_mem[79] = 8'b00000000;
        
        inst_mem[80] = 8'b11100011;   //beq x0, x0,loop1 //22
        inst_mem[81] = 8'b00001010;
        inst_mem[82] = 8'b00000000;
        inst_mem[83] = 8'b11111010;
        
        
        
	end
	
	
	always @(Inst_Address)
	begin
		Instruction={inst_mem[Inst_Address+3],inst_mem[Inst_Address+2],inst_mem[Inst_Address+1],inst_mem[Inst_Address]};
	end
endmodule
