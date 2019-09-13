/*********************************************
@ brainstorm how to load each mask for calculation:

	1. stored in SRAM at the first place
	2. hard code in FPGA

**********************************************/

module MaskLayer(	// control signals
						 input logic CLK,
						 input logic RESET,	// active high
							// input image
						 input logic [0:44999]image ,
							// output image
						 //notice the output pictures are stored in the fixed range in the SRAM
							// process control signal
						 input logic start, 	// active high
							// process control output 
						 output logic done,  // active high
							// SRAM control signals
						 // need modified to adapt for the SRAM
						 output logic [0:4]  confidence 
						 );

						 enum logic [4:0] {  startFirstMask,//5'h00
													waitState,
													doneState,	
													storeFirstConf, 
													startSecondMask, 
													storeSecondConf, 
													startThirdMask, 
													storeThirdConf, 
													startFourthMask, 
													storeFourthConf, 
													startFifthMask, 
													storeFifthConf
													} state, nextState;
						 
						 logic [10:0] eachConfidence_BLK [0:4];           // each confidence register input 
						 logic [10:0] eachConfidence_WHT [0:4];
						 logic [10:0] eachConfidence_BLK_out [0:4];		 // each confidence register output
						 logic [10:0] eachConfidence_WHT_out [0:4];
						 logic start1, start2, start3, start4, start5;// five start signals to five mask paths
						 logic done1, done2, done3, done4, done5;		 // five done signals to five mask paths
						 logic WE1, WE2, WE3, WE4, WE5;					 // five write enable signals to five confidence register
						 assign confidence[0]= (eachConfidence_BLK_out[0]>250 && eachConfidence_WHT_out[0]>250) ? 1'b1 : 1'b0;	// confidence bound is 700
						 assign confidence[1]= (eachConfidence_BLK_out[1]>250 && eachConfidence_WHT_out[1]>250) ? 1'b1 : 1'b0;
						 assign confidence[2]= (eachConfidence_BLK_out[2]>250 && eachConfidence_WHT_out[2]>250) ? 1'b1 : 1'b0;
						 assign confidence[3]= (eachConfidence_BLK_out[3]>250 && eachConfidence_WHT_out[3]>250) ? 1'b1 : 1'b0;
						 assign confidence[4]= (eachConfidence_BLK_out[4]>250 && eachConfidence_WHT_out[4]>250) ? 1'b1 : 1'b0;


 
	 // module declaration
	 MaskOnePath Mask1( .CLK(CLK), .RESET(RESET), .start(start1), .done(done1), .image({image[0:112],image[300:412],image[600:712],image[900:1012],image[1200:1312],image[1500:1612],image[1800:1912],image[2100:2212],image[2400:2512],image[2700:2812],image[3000:3112],image[3300:3412],image[3600:3712],image[3900:4012],image[4200:4312],image[4500:4612],image[4800:4912],image[5100:5212],image[5400:5512],image[5700:5812],image[6000:6112],image[6300:6412],image[6600:6712],image[6900:7012],image[7200:7312],image[7500:7612],image[7800:7912],image[8100:8212],image[8400:8512],image[8700:8812],image[9000:9112],image[9300:9412],image[9600:9712],image[9900:10012],image[10200:10312],image[10500:10612],image[10800:10912],image[11100:11212],image[11400:11512],image[11700:11812],image[12000:12112],image[12300:12412],image[12600:12712],image[12900:13012],image[13200:13312],image[13500:13612],image[13800:13912],image[14100:14212],image[14400:14512],image[14700:14812],image[15000:15112],image[15300:15412],image[15600:15712],image[15900:16012],image[16200:16312],image[16500:16612],image[16800:16912],image[17100:17212],image[17400:17512],image[17700:17812],image[18000:18112],image[18300:18412],image[18600:18712],image[18900:19012],image[19200:19312],image[19500:19612],image[19800:19912],image[20100:20212],image[20400:20512],image[20700:20812],image[21000:21112],image[21300:21412],image[21600:21712],image[21900:22012],image[22200:22312],image[22500:22612],image[22800:22912],image[23100:23212],image[23400:23512],image[23700:23812],image[24000:24112],image[24300:24412],image[24600:24712],image[24900:25012],image[25200:25312],image[25500:25612],image[25800:25912],image[26100:26212],image[26400:26512],image[26700:26812],image[27000:27112],image[27300:27412],image[27600:27712],image[27900:28012],image[28200:28312],image[28500:28612],image[28800:28912],image[29100:29212],image[29400:29512],image[29700:29812],image[30000:30112],image[30300:30412],image[30600:30712],image[30900:31012],image[31200:31312],image[31500:31612],image[31800:31912],image[32100:32212],image[32400:32512],image[32700:32812],image[33000:33112],image[33300:33412],image[33600:33712],image[33900:34012],image[34200:34312],image[34500:34612],image[34800:34912],image[35100:35212],image[35400:35512],image[35700:35812],image[36000:36112],image[36300:36412],image[36600:36712],image[36900:37012],image[37200:37312],image[37500:37612],image[37800:37912],image[38100:38212],image[38400:38512],image[38700:38812],image[39000:39112],image[39300:39412],image[39600:39712],image[39900:40012],image[40200:40312],image[40500:40612],image[40800:40912],image[41100:41212],image[41400:41512],image[41700:41812],image[42000:42112],image[42300:42412],image[42600:42712],image[42900:43012],image[43200:43312],image[43500:43612],image[43800:43912],image[44100:44212],image[44400:44512],image[44700:44812]}), .confidence_BLK(eachConfidence_BLK[0]) , .confidence_WHT(eachConfidence_WHT[0]));
	 MaskOnePath Mask2( .CLK(CLK), .RESET(RESET), .start(start2), .done(done2), .image({image[49:161],image[349:461],image[649:761],image[949:1061],image[1249:1361],image[1549:1661],image[1849:1961],image[2149:2261],image[2449:2561],image[2749:2861],image[3049:3161],image[3349:3461],image[3649:3761],image[3949:4061],image[4249:4361],image[4549:4661],image[4849:4961],image[5149:5261],image[5449:5561],image[5749:5861],image[6049:6161],image[6349:6461],image[6649:6761],image[6949:7061],image[7249:7361],image[7549:7661],image[7849:7961],image[8149:8261],image[8449:8561],image[8749:8861],image[9049:9161],image[9349:9461],image[9649:9761],image[9949:10061],image[10249:10361],image[10549:10661],image[10849:10961],image[11149:11261],image[11449:11561],image[11749:11861],image[12049:12161],image[12349:12461],image[12649:12761],image[12949:13061],image[13249:13361],image[13549:13661],image[13849:13961],image[14149:14261],image[14449:14561],image[14749:14861],image[15049:15161],image[15349:15461],image[15649:15761],image[15949:16061],image[16249:16361],image[16549:16661],image[16849:16961],image[17149:17261],image[17449:17561],image[17749:17861],image[18049:18161],image[18349:18461],image[18649:18761],image[18949:19061],image[19249:19361],image[19549:19661],image[19849:19961],image[20149:20261],image[20449:20561],image[20749:20861],image[21049:21161],image[21349:21461],image[21649:21761],image[21949:22061],image[22249:22361],image[22549:22661],image[22849:22961],image[23149:23261],image[23449:23561],image[23749:23861],image[24049:24161],image[24349:24461],image[24649:24761],image[24949:25061],image[25249:25361],image[25549:25661],image[25849:25961],image[26149:26261],image[26449:26561],image[26749:26861],image[27049:27161],image[27349:27461],image[27649:27761],image[27949:28061],image[28249:28361],image[28549:28661],image[28849:28961],image[29149:29261],image[29449:29561],image[29749:29861],image[30049:30161],image[30349:30461],image[30649:30761],image[30949:31061],image[31249:31361],image[31549:31661],image[31849:31961],image[32149:32261],image[32449:32561],image[32749:32861],image[33049:33161],image[33349:33461],image[33649:33761],image[33949:34061],image[34249:34361],image[34549:34661],image[34849:34961],image[35149:35261],image[35449:35561],image[35749:35861],image[36049:36161],image[36349:36461],image[36649:36761],image[36949:37061],image[37249:37361],image[37549:37661],image[37849:37961],image[38149:38261],image[38449:38561],image[38749:38861],image[39049:39161],image[39349:39461],image[39649:39761],image[39949:40061],image[40249:40361],image[40549:40661],image[40849:40961],image[41149:41261],image[41449:41561],image[41749:41861],image[42049:42161],image[42349:42461],image[42649:42761],image[42949:43061],image[43249:43361],image[43549:43661],image[43849:43961],image[44149:44261],image[44449:44561],image[44749:44861]}), .confidence_BLK(eachConfidence_BLK[1]) , .confidence_WHT(eachConfidence_WHT[1]));
	 MaskOnePath Mask3( .CLK(CLK), .RESET(RESET), .start(start3), .done(done3), .image({image[98:210],image[398:510],image[698:810],image[998:1110],image[1298:1410],image[1598:1710],image[1898:2010],image[2198:2310],image[2498:2610],image[2798:2910],image[3098:3210],image[3398:3510],image[3698:3810],image[3998:4110],image[4298:4410],image[4598:4710],image[4898:5010],image[5198:5310],image[5498:5610],image[5798:5910],image[6098:6210],image[6398:6510],image[6698:6810],image[6998:7110],image[7298:7410],image[7598:7710],image[7898:8010],image[8198:8310],image[8498:8610],image[8798:8910],image[9098:9210],image[9398:9510],image[9698:9810],image[9998:10110],image[10298:10410],image[10598:10710],image[10898:11010],image[11198:11310],image[11498:11610],image[11798:11910],image[12098:12210],image[12398:12510],image[12698:12810],image[12998:13110],image[13298:13410],image[13598:13710],image[13898:14010],image[14198:14310],image[14498:14610],image[14798:14910],image[15098:15210],image[15398:15510],image[15698:15810],image[15998:16110],image[16298:16410],image[16598:16710],image[16898:17010],image[17198:17310],image[17498:17610],image[17798:17910],image[18098:18210],image[18398:18510],image[18698:18810],image[18998:19110],image[19298:19410],image[19598:19710],image[19898:20010],image[20198:20310],image[20498:20610],image[20798:20910],image[21098:21210],image[21398:21510],image[21698:21810],image[21998:22110],image[22298:22410],image[22598:22710],image[22898:23010],image[23198:23310],image[23498:23610],image[23798:23910],image[24098:24210],image[24398:24510],image[24698:24810],image[24998:25110],image[25298:25410],image[25598:25710],image[25898:26010],image[26198:26310],image[26498:26610],image[26798:26910],image[27098:27210],image[27398:27510],image[27698:27810],image[27998:28110],image[28298:28410],image[28598:28710],image[28898:29010],image[29198:29310],image[29498:29610],image[29798:29910],image[30098:30210],image[30398:30510],image[30698:30810],image[30998:31110],image[31298:31410],image[31598:31710],image[31898:32010],image[32198:32310],image[32498:32610],image[32798:32910],image[33098:33210],image[33398:33510],image[33698:33810],image[33998:34110],image[34298:34410],image[34598:34710],image[34898:35010],image[35198:35310],image[35498:35610],image[35798:35910],image[36098:36210],image[36398:36510],image[36698:36810],image[36998:37110],image[37298:37410],image[37598:37710],image[37898:38010],image[38198:38310],image[38498:38610],image[38798:38910],image[39098:39210],image[39398:39510],image[39698:39810],image[39998:40110],image[40298:40410],image[40598:40710],image[40898:41010],image[41198:41310],image[41498:41610],image[41798:41910],image[42098:42210],image[42398:42510],image[42698:42810],image[42998:43110],image[43298:43410],image[43598:43710],image[43898:44010],image[44198:44310],image[44498:44610],image[44798:44910]}), .confidence_BLK(eachConfidence_BLK[2]) , .confidence_WHT(eachConfidence_WHT[2]));
	 MaskOnePath Mask4( .CLK(CLK), .RESET(RESET), .start(start4), .done(done4), .image({image[143:255],image[443:555],image[743:855],image[1043:1155],image[1343:1455],image[1643:1755],image[1943:2055],image[2243:2355],image[2543:2655],image[2843:2955],image[3143:3255],image[3443:3555],image[3743:3855],image[4043:4155],image[4343:4455],image[4643:4755],image[4943:5055],image[5243:5355],image[5543:5655],image[5843:5955],image[6143:6255],image[6443:6555],image[6743:6855],image[7043:7155],image[7343:7455],image[7643:7755],image[7943:8055],image[8243:8355],image[8543:8655],image[8843:8955],image[9143:9255],image[9443:9555],image[9743:9855],image[10043:10155],image[10343:10455],image[10643:10755],image[10943:11055],image[11243:11355],image[11543:11655],image[11843:11955],image[12143:12255],image[12443:12555],image[12743:12855],image[13043:13155],image[13343:13455],image[13643:13755],image[13943:14055],image[14243:14355],image[14543:14655],image[14843:14955],image[15143:15255],image[15443:15555],image[15743:15855],image[16043:16155],image[16343:16455],image[16643:16755],image[16943:17055],image[17243:17355],image[17543:17655],image[17843:17955],image[18143:18255],image[18443:18555],image[18743:18855],image[19043:19155],image[19343:19455],image[19643:19755],image[19943:20055],image[20243:20355],image[20543:20655],image[20843:20955],image[21143:21255],image[21443:21555],image[21743:21855],image[22043:22155],image[22343:22455],image[22643:22755],image[22943:23055],image[23243:23355],image[23543:23655],image[23843:23955],image[24143:24255],image[24443:24555],image[24743:24855],image[25043:25155],image[25343:25455],image[25643:25755],image[25943:26055],image[26243:26355],image[26543:26655],image[26843:26955],image[27143:27255],image[27443:27555],image[27743:27855],image[28043:28155],image[28343:28455],image[28643:28755],image[28943:29055],image[29243:29355],image[29543:29655],image[29843:29955],image[30143:30255],image[30443:30555],image[30743:30855],image[31043:31155],image[31343:31455],image[31643:31755],image[31943:32055],image[32243:32355],image[32543:32655],image[32843:32955],image[33143:33255],image[33443:33555],image[33743:33855],image[34043:34155],image[34343:34455],image[34643:34755],image[34943:35055],image[35243:35355],image[35543:35655],image[35843:35955],image[36143:36255],image[36443:36555],image[36743:36855],image[37043:37155],image[37343:37455],image[37643:37755],image[37943:38055],image[38243:38355],image[38543:38655],image[38843:38955],image[39143:39255],image[39443:39555],image[39743:39855],image[40043:40155],image[40343:40455],image[40643:40755],image[40943:41055],image[41243:41355],image[41543:41655],image[41843:41955],image[42143:42255],image[42443:42555],image[42743:42855],image[43043:43155],image[43343:43455],image[43643:43755],image[43943:44055],image[44243:44355],image[44543:44655],image[44843:44955]}), .confidence_BLK(eachConfidence_BLK[3]) , .confidence_WHT(eachConfidence_WHT[3]));
	 MaskOnePath Mask5( .CLK(CLK), .RESET(RESET), .start(start5), .done(done5), .image({image[187:299],image[487:599],image[787:899],image[1087:1199],image[1387:1499],image[1687:1799],image[1987:2099],image[2287:2399],image[2587:2699],image[2887:2999],image[3187:3299],image[3487:3599],image[3787:3899],image[4087:4199],image[4387:4499],image[4687:4799],image[4987:5099],image[5287:5399],image[5587:5699],image[5887:5999],image[6187:6299],image[6487:6599],image[6787:6899],image[7087:7199],image[7387:7499],image[7687:7799],image[7987:8099],image[8287:8399],image[8587:8699],image[8887:8999],image[9187:9299],image[9487:9599],image[9787:9899],image[10087:10199],image[10387:10499],image[10687:10799],image[10987:11099],image[11287:11399],image[11587:11699],image[11887:11999],image[12187:12299],image[12487:12599],image[12787:12899],image[13087:13199],image[13387:13499],image[13687:13799],image[13987:14099],image[14287:14399],image[14587:14699],image[14887:14999],image[15187:15299],image[15487:15599],image[15787:15899],image[16087:16199],image[16387:16499],image[16687:16799],image[16987:17099],image[17287:17399],image[17587:17699],image[17887:17999],image[18187:18299],image[18487:18599],image[18787:18899],image[19087:19199],image[19387:19499],image[19687:19799],image[19987:20099],image[20287:20399],image[20587:20699],image[20887:20999],image[21187:21299],image[21487:21599],image[21787:21899],image[22087:22199],image[22387:22499],image[22687:22799],image[22987:23099],image[23287:23399],image[23587:23699],image[23887:23999],image[24187:24299],image[24487:24599],image[24787:24899],image[25087:25199],image[25387:25499],image[25687:25799],image[25987:26099],image[26287:26399],image[26587:26699],image[26887:26999],image[27187:27299],image[27487:27599],image[27787:27899],image[28087:28199],image[28387:28499],image[28687:28799],image[28987:29099],image[29287:29399],image[29587:29699],image[29887:29999],image[30187:30299],image[30487:30599],image[30787:30899],image[31087:31199],image[31387:31499],image[31687:31799],image[31987:32099],image[32287:32399],image[32587:32699],image[32887:32999],image[33187:33299],image[33487:33599],image[33787:33899],image[34087:34199],image[34387:34499],image[34687:34799],image[34987:35099],image[35287:35399],image[35587:35699],image[35887:35999],image[36187:36299],image[36487:36599],image[36787:36899],image[37087:37199],image[37387:37499],image[37687:37799],image[37987:38099],image[38287:38399],image[38587:38699],image[38887:38999],image[39187:39299],image[39487:39599],image[39787:39899],image[40087:40199],image[40387:40499],image[40687:40799],image[40987:41099],image[41287:41399],image[41587:41699],image[41887:41999],image[42187:42299],image[42487:42599],image[42787:42899],image[43087:43199],image[43387:43499],image[43687:43799],image[43987:44099],image[44287:44399],image[44587:44699],image[44887:44999]}), .confidence_BLK(eachConfidence_BLK[4]) , .confidence_WHT(eachConfidence_WHT[4]));
	 ConfidenceReg ConfReg1 ( .CLK(CLK), .RESET(RESET), .WE(WE1), .confidence_BLK(eachConfidence_BLK[0]) , .confidence_WHT(eachConfidence_WHT[0]), .confidence_BLK_out(eachConfidence_BLK_out[0]), .confidence_WHT_out(eachConfidence_WHT_out[0]));
	 ConfidenceReg ConfReg2 ( .CLK(CLK), .RESET(RESET), .WE(WE2), .confidence_BLK(eachConfidence_BLK[1]) , .confidence_WHT(eachConfidence_WHT[1]), .confidence_BLK_out(eachConfidence_BLK_out[1]), .confidence_WHT_out(eachConfidence_WHT_out[1]));
	 ConfidenceReg ConfReg3 ( .CLK(CLK), .RESET(RESET), .WE(WE3), .confidence_BLK(eachConfidence_BLK[2]) , .confidence_WHT(eachConfidence_WHT[2]), .confidence_BLK_out(eachConfidence_BLK_out[2]), .confidence_WHT_out(eachConfidence_WHT_out[2]));
	 ConfidenceReg ConfReg4 ( .CLK(CLK), .RESET(RESET), .WE(WE4), .confidence_BLK(eachConfidence_BLK[3]) , .confidence_WHT(eachConfidence_WHT[3]), .confidence_BLK_out(eachConfidence_BLK_out[3]), .confidence_WHT_out(eachConfidence_WHT_out[3]));
	 ConfidenceReg ConfReg5 ( .CLK(CLK), .RESET(RESET), .WE(WE5), .confidence_BLK(eachConfidence_BLK[4]) , .confidence_WHT(eachConfidence_WHT[4]), .confidence_BLK_out(eachConfidence_BLK_out[4]), .confidence_WHT_out(eachConfidence_WHT_out[4]));
	 // basic flip flop
	 always_ff @ (posedge CLK)
    begin
        if (RESET) 
            state <= waitState;
        else 
            state <= nextState;
    end
	
	// state transition
	always_comb
	begin
		nextState = state;
		unique case (state)
			waitState: 
				begin
				if (start == 1'b1)
					nextState = startFirstMask;
				end 
			startFirstMask:
				begin
				if (done1 == 1'b1)
					nextState = storeFirstConf;
				end
				
			storeFirstConf:
				nextState = startSecondMask;
				
			startSecondMask:
				if (done2 == 1'b1)
					nextState = storeSecondConf;
			storeSecondConf:
				nextState = startThirdMask;
				
			startThirdMask:
				if (done3 == 1'b1)
					nextState = storeThirdConf;
			storeThirdConf:
				nextState = startFourthMask;
				
			startFourthMask:
				if (done4 == 1'b1)
					nextState = storeFourthConf;
			storeFourthConf:
				nextState = startFifthMask;
				
			startFifthMask:
				if (done5 == 1'b1)
					nextState = storeFifthConf;
			storeFifthConf:
				nextState = doneState;
				
			doneState:
				nextState = waitState;
			default: nextState = waitState;
		endcase 
		
		// state implementation	
		/*initialize the control signals to inactive at the first place*/
		start1=1'b0;
		start2=1'b0;
		start3=1'b0;
		start4=1'b0;
		start5=1'b0;
		WE1 = 1'b0;
		WE2 = 1'b0;
		WE3 = 1'b0;
		WE4 = 1'b0;
		WE5 = 1'b0;
		done = 1'b0;
		unique case(state)
			waitState : 
				done = 1'b1;
			startFirstMask:
				start1=1'b1;
			storeFirstConf :
				begin
					start1=1'b1;
					WE1=1'b1;
				end 
			startSecondMask :
				start2=1'b1;
			storeSecondConf :
				begin
					start2=1'b1;
					WE2=1'b1;
				end
			startThirdMask :
				start3=1'b1;
			storeThirdConf :
				begin
					start3=1'b1;
					WE3=1'b1;
				end
			startFourthMask :
				start4=1'b1;
			storeFourthConf :
				begin 
					start4=1'b1;
					WE4=1'b1;
				end
			startFifthMask :
				start5=1'b1;
			storeFifthConf :
				begin
					start5=1'b1;
					WE5=1'b1;
				end
			doneState :
				done = 1'b1;
		endcase
	end


endmodule


