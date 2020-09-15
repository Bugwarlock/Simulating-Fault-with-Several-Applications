`timescale 1ns/1ns

module tester();
	parameter inputWidth = 32;
	parameter outputWidth = 32;
	parameter testCount = 60;
	
	reg [0:inputWidth-1] inp;
	wire [outputWidth - 1:0] out, outnet;
	
	reg detected = 0;
	integer i;
	integer testFile, faultFile, dictionaryFile, status;
	real numOfFaults = 6508;
	real numOfDetecteds = 0;
	real coverage = 0;
	reg[inputWidth - 1:0] testVector;
	reg[60*8:1] wireName;
	reg[testCount - 1:0] syndrome;
	reg stuckAtVal;
	
	c6288_net GUT 		(inp[0],inp[1],inp[2],inp[3],inp[4],inp[5],inp[6],inp[7],inp[8],inp[9],inp[10],inp[11],inp[12],
  inp[13],inp[14],inp[15],inp[16],inp[17],inp[18],inp[19],inp[20],inp[21],inp[22],inp[23],inp[24],inp[25],inp[26],
  inp[27],inp[28],inp[29],inp[30],inp[31],
  out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7],out[8],out[9],out[10],out[11],out[12],out[13],out[14],
  out[15],out[16],out[17],out[18],out[19],out[20],out[21],out[22],out[23],out[24],out[25],out[26],out[27],out[28],
  out[29],out[30],out[31]);
	c6288_net FUT	(inp[0],inp[1],inp[2],inp[3],inp[4],inp[5],inp[6],inp[7],inp[8],inp[9],inp[10],inp[11],inp[12],
  inp[13],inp[14],inp[15],inp[16],inp[17],inp[18],inp[19],inp[20],inp[21],inp[22],inp[23],inp[24],inp[25],inp[26],
  inp[27],inp[28],inp[29],inp[30],inp[31],
  outnet[0],outnet[1],outnet[2],outnet[3],outnet[4],outnet[5],outnet[6],outnet[7],outnet[8],outnet[9],outnet[10],outnet[11],outnet[12],outnet[13],outnet[14],
  outnet[15],outnet[16],outnet[17],outnet[18],outnet[19],outnet[20],outnet[21],outnet[22],outnet[23],outnet[24],outnet[25],outnet[26],outnet[27],outnet[28],
  outnet[29],outnet[30],outnet[31]);
	
	initial
	begin
		faultFile = $fopen ("c6288_fault.flt", "w");
		$FaultCollapsing(tester.FUT,"c6288_fault.flt");
		$fclose(faultFile);
		#10
		dictionaryFile = $fopen("c6288.dct", "w");
		faultFile = $fopen ("c6288_fault.flt", "r");
		while ( !$feof(faultFile))
		begin
			i = 0;
			status = $fscanf (faultFile, "%s s@%b\n", wireName, stuckAtVal);
			$InjectFault ( wireName, stuckAtVal);
			testFile = $fopen ("c6288.pat", "r");
			detected = 1'b 0;
			while ( !$feof(testFile))
			begin
				#30
				status = $fscanf (testFile, "%b\n", testVector);
				inp = testVector;
				#60;
				if (out != outnet)
				begin
					detected = 1'b 1;
					syndrome[i] = 1'b 1;
				end
				else
					syndrome[i] = 1'b 0;
				i = i + 1;
			end

      if (syndrome != 0)
			  numOfDetecteds = numOfDetecteds + 1;
      
			$fclose (testFile);
			$RemoveFault(wireName);
			$fwrite (dictionaryFile, "%s, %b \n", wireName, syndrome);
			#30;
		end
		coverage = numOfDetecteds / numOfFaults;
		$fwrite (dictionaryFile, "Coverage: %f\n", coverage);
		$fclose(dictionaryFile);		
		$stop;
	end
endmodule
