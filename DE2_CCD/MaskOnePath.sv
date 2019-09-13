module MaskOnePath (	
							input logic [0:16949] image  ,
							input logic CLK, RESET,
							input logic start,		// active high
							output logic done,		// active high
							output logic [9:0] confidence_BLK,
							output logic [9:0] confidence_WHT
						  );
						  enum logic [1:0] { waitState, 
													startAdd,
													doneState
													} state, nextState;
						  
	 // basic flip flop
	 always_ff @ (posedge CLK)
    begin
        if (RESET) 
            state <= waitState;
        else 
            state <= nextState;
    end
	 
	
	always_comb
	begin
		// state transition
		nextState = state;
		unique case(state)
			waitState : 
				if (start == 1'b1)
					nextState = startAdd;
			startAdd :
				nextState = doneState;
			doneState :
				if (start == 1'b0)
					nextState = waitState;
			default:
				nextState=waitState;
		endcase
		
		// when not to calculate, set confidence to zero
		confidence_BLK=10'b0;
		confidence_WHT=10'b0;
		
		done=1'b0;
		// state implementation		
		unique case(state)
			waitState : ; // do nothing 
			startAdd:
			begin
				confidence_WHT = image[5839]+image[5840]+image[5841]+image[5842]+image[5843]+image[5844]+image[5845]+image[5846]+image[5847]+image[5906]+image[5907]+image[5908]+image[5909]+image[5910]+image[5911]+image[5912]+image[5913]+image[5914]+image[5952]+image[5953]+image[5954]+image[5955]+image[5956]+image[5957]+image[5958]+image[5959]+image[5960]+image[6019]+image[6020]+image[6021]+image[6022]+image[6023]+image[6024]+image[6025]+image[6026]+image[6027]+image[6723]+image[6724]+image[6725]+image[6835]+image[6836]+image[6837]+image[6838]+image[6839]+image[6948]+image[6949]+image[6950]+image[6951]+image[6952]+image[7060]+image[7061]+image[7062]+image[7063]+image[7064]+image[7065]+image[7066]+image[7173]+image[7174]+image[7175]+image[7176]+image[7177]+image[7178]+image[7179]+image[7286]+image[7287]+image[7288]+image[7289]+image[7290]+image[7291]+image[7292]+image[7399]+image[7400]+image[7401]+image[7402]+image[7403]+image[7404]+image[7405]+image[7512]+image[7513]+image[7514]+image[7515]+image[7516]+image[7517]+image[7518]+image[7625]+image[7626]+image[7627]+image[7628]+image[7629]+image[7630]+image[7631]+image[7738]+image[7739]+image[7740]+image[7741]+image[7742]+image[7743]+image[7744]+image[7851]+image[7852]+image[7853]+image[7854]+image[7855]+image[7856]+image[7857]+image[7964]+image[7965]+image[7966]+image[7967]+image[7968]+image[7969]+image[7970]+image[8077]+image[8078]+image[8079]+image[8080]+image[8081]+image[8082]+image[8083]+image[8190]+image[8191]+image[8192]+image[8193]+image[8194]+image[8195]+image[8196]+image[8303]+image[8304]+image[8305]+image[8306]+image[8307]+image[8308]+image[8309]+image[8416]+image[8417]+image[8418]+image[8419]+image[8420]+image[8421]+image[8422]+image[8529]+image[8530]+image[8531]+image[8532]+image[8533]+image[8534]+image[8535]+image[8618]+image[8619]+image[8620]+image[8621]+image[8622]+image[8623]+image[8624]+image[8625]+image[8626]+image[8642]+image[8643]+image[8644]+image[8645]+image[8646]+image[8647]+image[8648]+image[8664]+image[8665]+image[8666]+image[8667]+image[8668]+image[8669]+image[8670]+image[8731]+image[8732]+image[8733]+image[8734]+image[8735]+image[8736]+image[8737]+image[8738]+image[8739]+image[8740]+image[8755]+image[8756]+image[8757]+image[8758]+image[8759]+image[8760]+image[8761]+image[8776]+image[8777]+image[8778]+image[8779]+image[8780]+image[8781]+image[8782]+image[8783]+image[8784]+image[8844]+image[8845]+image[8846]+image[8847]+image[8848]+image[8849]+image[8850]+image[8851]+image[8852]+image[8853]+image[8854]+image[8868]+image[8869]+image[8870]+image[8871]+image[8872]+image[8873]+image[8874]+image[8888]+image[8889]+image[8890]+image[8891]+image[8892]+image[8893]+image[8894]+image[8895]+image[8896]+image[8897]+image[8898]+image[8957]+image[8958]+image[8959]+image[8960]+image[8961]+image[8962]+image[8963]+image[8964]+image[8965]+image[8966]+image[8967]+image[8981]+image[8982]+image[8983]+image[8984]+image[8985]+image[8986]+image[8987]+image[9001]+image[9002]+image[9003]+image[9004]+image[9005]+image[9006]+image[9007]+image[9008]+image[9009]+image[9010]+image[9011]+image[9070]+image[9071]+image[9072]+image[9073]+image[9074]+image[9075]+image[9076]+image[9077]+image[9078]+image[9079]+image[9080]+image[9094]+image[9095]+image[9096]+image[9097]+image[9098]+image[9099]+image[9100]+image[9114]+image[9115]+image[9116]+image[9117]+image[9118]+image[9119]+image[9120]+image[9121]+image[9122]+image[9123]+image[9124]+image[9184]+image[9185]+image[9186]+image[9187]+image[9188]+image[9189]+image[9190]+image[9191]+image[9192]+image[9193]+image[9207]+image[9208]+image[9209]+image[9210]+image[9211]+image[9212]+image[9213]+image[9227]+image[9228]+image[9229]+image[9230]+image[9231]+image[9232]+image[9233]+image[9234]+image[9235]+image[9236]+image[9298]+image[9299]+image[9300]+image[9301]+image[9302]+image[9303]+image[9304]+image[9305]+image[9306]+image[9320]+image[9321]+image[9322]+image[9323]+image[9324]+image[9325]+image[9326]+image[9340]+image[9341]+image[9342]+image[9343]+image[9344]+image[9345]+image[9346]+image[9347]+image[9348]+image[9412]+image[9413]+image[9414]+image[9415]+image[9416]+image[9417]+image[9418]+image[9419]+image[9433]+image[9434]+image[9435]+image[9436]+image[9437]+image[9438]+image[9439]+image[9453]+image[9454]+image[9455]+image[9456]+image[9457]+image[9458]+image[9459]+image[9460]+image[9546]+image[9547]+image[9548]+image[9549]+image[9550]+image[9551]+image[9552]+image[9659]+image[9660]+image[9661]+image[9662]+image[9663]+image[9664]+image[9665]+image[10541]+image[10542]+image[10543]+image[10544]+image[10545]+image[10546]+image[10547]+image[10585]+image[10586]+image[10587]+image[10588]+image[10589]+image[10590]+image[10591]+image[10655]+image[10656]+image[10657]+image[10658]+image[10659]+image[10660]+image[10661]+image[10697]+image[10698]+image[10699]+image[10700]+image[10701]+image[10702]+image[10703]+image[10769]+image[10770]+image[10771]+image[10772]+image[10773]+image[10774]+image[10775]+image[10809]+image[10810]+image[10811]+image[10812]+image[10813]+image[10814]+image[10815]+image[10883]+image[10884]+image[10885]+image[10886]+image[10887]+image[10888]+image[10922]+image[10923]+image[10924]+image[10925]+image[10926]+image[10927]+image[11569]+image[11570]+image[11596]+image[11597]+image[11682]+image[11683]+image[11684]+image[11708]+image[11709]+image[11710]+image[11795]+image[11796]+image[11797]+image[11798]+image[11820]+image[11821]+image[11822]+image[11823]+image[11908]+image[11909]+image[11910]+image[11911]+image[11933]+image[11934]+image[11935]+image[11936]+image[12021]+image[12022]+image[12023]+image[12024]+image[12046]+image[12047]+image[12048]+image[12049]+image[12135]+image[12136]+image[12137]+image[12159]+image[12160]+image[12161]+image[12249]+image[12250]+image[12272]+image[12273]+image[13609]+image[13610]+image[13611]+image[13612]+image[13613]+image[13614]+image[13615]+image[13616]+image[13617]+image[13618]+image[13619]+image[13620]+image[13621]+image[13622]+image[13623]+image[13624]+image[13625]+image[13722]+image[13723]+image[13724]+image[13725]+image[13726]+image[13727]+image[13728]+image[13729]+image[13730]+image[13731]+image[13732]+image[13733]+image[13734]+image[13735]+image[13736]+image[13737]+image[13738]+image[13837]+image[13838]+image[13839]+image[13840]+image[13841]+image[13842]+image[13843]+image[13844]+image[13845]+image[13846]+image[13847]+image[13848]+image[13849];
				confidence_BLK = (~image[4777])+(~image[4778])+(~image[4779])+(~image[4780])+(~image[4781])+(~image[4782])+(~image[4783])+(~image[4784])+(~image[4785])+(~image[4821])+(~image[4822])+(~image[4823])+(~image[4824])+(~image[4825])+(~image[4826])+(~image[4827])+(~image[4828])+(~image[4829])+(~image[4889])+(~image[4890])+(~image[4891])+(~image[4892])+(~image[4893])+(~image[4894])+(~image[4895])+(~image[4896])+(~image[4897])+(~image[4898])+(~image[4934])+(~image[4935])+(~image[4936])+(~image[4937])+(~image[4938])+(~image[4939])+(~image[4940])+(~image[4941])+(~image[4942])+(~image[4943])+(~image[5001])+(~image[5002])+(~image[5003])+(~image[5004])+(~image[5005])+(~image[5006])+(~image[5007])+(~image[5008])+(~image[5009])+(~image[5010])+(~image[5011])+(~image[5047])+(~image[5048])+(~image[5049])+(~image[5050])+(~image[5051])+(~image[5052])+(~image[5053])+(~image[5054])+(~image[5055])+(~image[5056])+(~image[5057])+(~image[5114])+(~image[5115])+(~image[5116])+(~image[5117])+(~image[5118])+(~image[5119])+(~image[5120])+(~image[5121])+(~image[5122])+(~image[5123])+(~image[5124])+(~image[5160])+(~image[5161])+(~image[5162])+(~image[5163])+(~image[5164])+(~image[5165])+(~image[5166])+(~image[5167])+(~image[5168])+(~image[5169])+(~image[5170])+(~image[5228])+(~image[5229])+(~image[5230])+(~image[5231])+(~image[5232])+(~image[5233])+(~image[5234])+(~image[5235])+(~image[5236])+(~image[5237])+(~image[5273])+(~image[5274])+(~image[5275])+(~image[5276])+(~image[5277])+(~image[5278])+(~image[5279])+(~image[5280])+(~image[5281])+(~image[5282])+(~image[5342])+(~image[5343])+(~image[5344])+(~image[5345])+(~image[5346])+(~image[5347])+(~image[5348])+(~image[5349])+(~image[5350])+(~image[5386])+(~image[5387])+(~image[5388])+(~image[5389])+(~image[5390])+(~image[5391])+(~image[5392])+(~image[5393])+(~image[5394])+(~image[6468])+(~image[6469])+(~image[6470])+(~image[6471])+(~image[6472])+(~image[6473])+(~image[6474])+(~image[6475])+(~image[6476])+(~image[6477])+(~image[6478])+(~image[6479])+(~image[6480])+(~image[6481])+(~image[6482])+(~image[6514])+(~image[6515])+(~image[6516])+(~image[6517])+(~image[6518])+(~image[6519])+(~image[6520])+(~image[6521])+(~image[6522])+(~image[6523])+(~image[6524])+(~image[6525])+(~image[6526])+(~image[6527])+(~image[6528])+(~image[6581])+(~image[6582])+(~image[6583])+(~image[6584])+(~image[6585])+(~image[6586])+(~image[6587])+(~image[6588])+(~image[6589])+(~image[6590])+(~image[6591])+(~image[6592])+(~image[6593])+(~image[6594])+(~image[6595])+(~image[6627])+(~image[6628])+(~image[6629])+(~image[6630])+(~image[6631])+(~image[6632])+(~image[6633])+(~image[6634])+(~image[6635])+(~image[6636])+(~image[6637])+(~image[6638])+(~image[6639])+(~image[6640])+(~image[6641])+(~image[6694])+(~image[6695])+(~image[6696])+(~image[6697])+(~image[6698])+(~image[6699])+(~image[6700])+(~image[6701])+(~image[6702])+(~image[6703])+(~image[6704])+(~image[6705])+(~image[6706])+(~image[6707])+(~image[6708])+(~image[6740])+(~image[6741])+(~image[6742])+(~image[6743])+(~image[6744])+(~image[6745])+(~image[6746])+(~image[6747])+(~image[6748])+(~image[6749])+(~image[6750])+(~image[6751])+(~image[6752])+(~image[6753])+(~image[6754])+(~image[6807])+(~image[6808])+(~image[6809])+(~image[6810])+(~image[6811])+(~image[6812])+(~image[6813])+(~image[6814])+(~image[6815])+(~image[6816])+(~image[6817])+(~image[6818])+(~image[6819])+(~image[6820])+(~image[6821])+(~image[6853])+(~image[6854])+(~image[6855])+(~image[6856])+(~image[6857])+(~image[6858])+(~image[6859])+(~image[6860])+(~image[6861])+(~image[6862])+(~image[6863])+(~image[6864])+(~image[6865])+(~image[6866])+(~image[6867])+(~image[6921])+(~image[6922])+(~image[6923])+(~image[6924])+(~image[6925])+(~image[6926])+(~image[6927])+(~image[6928])+(~image[6929])+(~image[6930])+(~image[6931])+(~image[6932])+(~image[6933])+(~image[6967])+(~image[6968])+(~image[6969])+(~image[6970])+(~image[6971])+(~image[6972])+(~image[6973])+(~image[6974])+(~image[6975])+(~image[6976])+(~image[6977])+(~image[6978])+(~image[6979])+(~image[7035])+(~image[7036])+(~image[7037])+(~image[7038])+(~image[7039])+(~image[7040])+(~image[7041])+(~image[7042])+(~image[7043])+(~image[7044])+(~image[7045])+(~image[7081])+(~image[7082])+(~image[7083])+(~image[7084])+(~image[7085])+(~image[7086])+(~image[7087])+(~image[7088])+(~image[7089])+(~image[7090])+(~image[7091])+(~image[10334])+(~image[10335])+(~image[10336])+(~image[10337])+(~image[10338])+(~image[10339])+(~image[10340])+(~image[10341])+(~image[10342])+(~image[10343])+(~image[10344])+(~image[10345])+(~image[10346])+(~image[10446])+(~image[10447])+(~image[10448])+(~image[10449])+(~image[10450])+(~image[10451])+(~image[10452])+(~image[10453])+(~image[10454])+(~image[10455])+(~image[10456])+(~image[10457])+(~image[10458])+(~image[10459])+(~image[10460])+(~image[10559])+(~image[10560])+(~image[10561])+(~image[10562])+(~image[10563])+(~image[10564])+(~image[10565])+(~image[10566])+(~image[10567])+(~image[10568])+(~image[10569])+(~image[10570])+(~image[10571])+(~image[10572])+(~image[10573])+(~image[10673])+(~image[10674])+(~image[10675])+(~image[10676])+(~image[10677])+(~image[10678])+(~image[10679])+(~image[10680])+(~image[10681])+(~image[10682])+(~image[10683])+(~image[10684])+(~image[10685])+(~image[12816])+(~image[12817])+(~image[12818])+(~image[12819])+(~image[12820])+(~image[12821])+(~image[12822])+(~image[12823])+(~image[12824])+(~image[12825])+(~image[12826])+(~image[12827])+(~image[12828])+(~image[12829])+(~image[12830])+(~image[12831])+(~image[12832])+(~image[12833])+(~image[12834])+(~image[12835])+(~image[12836])+(~image[12929])+(~image[12930])+(~image[12931])+(~image[12932])+(~image[12933])+(~image[12934])+(~image[12935])+(~image[12936])+(~image[12937])+(~image[12938])+(~image[12939])+(~image[12940])+(~image[12941])+(~image[12942])+(~image[12943])+(~image[12944])+(~image[12945])+(~image[12946])+(~image[12947])+(~image[12948])+(~image[12949])+(~image[13035])+(~image[13036])+(~image[13037])+(~image[13038])+(~image[13039])+(~image[13040])+(~image[13041])+(~image[13042])+(~image[13043])+(~image[13044])+(~image[13045])+(~image[13046])+(~image[13047])+(~image[13048])+(~image[13049])+(~image[13050])+(~image[13051])+(~image[13052])+(~image[13053])+(~image[13054])+(~image[13055])+(~image[13056])+(~image[13057])+(~image[13058])+(~image[13059])+(~image[13060])+(~image[13061])+(~image[13062])+(~image[13063])+(~image[13064])+(~image[13065])+(~image[13066])+(~image[13067])+(~image[13068])+(~image[13069])+(~image[13148])+(~image[13149])+(~image[13150])+(~image[13151])+(~image[13152])+(~image[13153])+(~image[13154])+(~image[13155])+(~image[13156])+(~image[13157])+(~image[13158])+(~image[13159])+(~image[13160])+(~image[13161])+(~image[13162])+(~image[13163])+(~image[13164])+(~image[13165])+(~image[13166])+(~image[13167])+(~image[13168])+(~image[13169])+(~image[13170])+(~image[13171])+(~image[13172])+(~image[13173])+(~image[13174])+(~image[13175])+(~image[13176])+(~image[13177])+(~image[13178])+(~image[13179])+(~image[13180])+(~image[13181])+(~image[13182])+(~image[14177])+(~image[14178])+(~image[14179])+(~image[14180])+(~image[14181])+(~image[14182])+(~image[14183])+(~image[14184])+(~image[14185])+(~image[14186])+(~image[14187])+(~image[14290])+(~image[14291])+(~image[14292])+(~image[14293])+(~image[14294])+(~image[14295])+(~image[14296])+(~image[14297])+(~image[14298])+(~image[14299])+(~image[14300])+(~image[14403])+(~image[14404])+(~image[14405])+(~image[14406])+(~image[14407])+(~image[14408])+(~image[14409])+(~image[14410])+(~image[14411])+(~image[14412])+(~image[14413])+(~image[14516])+(~image[14517])+(~image[14518])+(~image[14519])+(~image[14520])+(~image[14521])+(~image[14522])+(~image[14523])+(~image[14524])+(~image[14525])+(~image[14526])+(~image[14629])+(~image[14630])+(~image[14631])+(~image[14632])+(~image[14633])+(~image[14634])+(~image[14635])+(~image[14636])+(~image[14637])+(~image[14638])+(~image[14639]);
			end
			doneState:
				begin
				confidence_WHT = image[5839]+image[5840]+image[5841]+image[5842]+image[5843]+image[5844]+image[5845]+image[5846]+image[5847]+image[5906]+image[5907]+image[5908]+image[5909]+image[5910]+image[5911]+image[5912]+image[5913]+image[5914]+image[5952]+image[5953]+image[5954]+image[5955]+image[5956]+image[5957]+image[5958]+image[5959]+image[5960]+image[6019]+image[6020]+image[6021]+image[6022]+image[6023]+image[6024]+image[6025]+image[6026]+image[6027]+image[6723]+image[6724]+image[6725]+image[6835]+image[6836]+image[6837]+image[6838]+image[6839]+image[6948]+image[6949]+image[6950]+image[6951]+image[6952]+image[7060]+image[7061]+image[7062]+image[7063]+image[7064]+image[7065]+image[7066]+image[7173]+image[7174]+image[7175]+image[7176]+image[7177]+image[7178]+image[7179]+image[7286]+image[7287]+image[7288]+image[7289]+image[7290]+image[7291]+image[7292]+image[7399]+image[7400]+image[7401]+image[7402]+image[7403]+image[7404]+image[7405]+image[7512]+image[7513]+image[7514]+image[7515]+image[7516]+image[7517]+image[7518]+image[7625]+image[7626]+image[7627]+image[7628]+image[7629]+image[7630]+image[7631]+image[7738]+image[7739]+image[7740]+image[7741]+image[7742]+image[7743]+image[7744]+image[7851]+image[7852]+image[7853]+image[7854]+image[7855]+image[7856]+image[7857]+image[7964]+image[7965]+image[7966]+image[7967]+image[7968]+image[7969]+image[7970]+image[8077]+image[8078]+image[8079]+image[8080]+image[8081]+image[8082]+image[8083]+image[8190]+image[8191]+image[8192]+image[8193]+image[8194]+image[8195]+image[8196]+image[8303]+image[8304]+image[8305]+image[8306]+image[8307]+image[8308]+image[8309]+image[8416]+image[8417]+image[8418]+image[8419]+image[8420]+image[8421]+image[8422]+image[8529]+image[8530]+image[8531]+image[8532]+image[8533]+image[8534]+image[8535]+image[8618]+image[8619]+image[8620]+image[8621]+image[8622]+image[8623]+image[8624]+image[8625]+image[8626]+image[8642]+image[8643]+image[8644]+image[8645]+image[8646]+image[8647]+image[8648]+image[8664]+image[8665]+image[8666]+image[8667]+image[8668]+image[8669]+image[8670]+image[8731]+image[8732]+image[8733]+image[8734]+image[8735]+image[8736]+image[8737]+image[8738]+image[8739]+image[8740]+image[8755]+image[8756]+image[8757]+image[8758]+image[8759]+image[8760]+image[8761]+image[8776]+image[8777]+image[8778]+image[8779]+image[8780]+image[8781]+image[8782]+image[8783]+image[8784]+image[8844]+image[8845]+image[8846]+image[8847]+image[8848]+image[8849]+image[8850]+image[8851]+image[8852]+image[8853]+image[8854]+image[8868]+image[8869]+image[8870]+image[8871]+image[8872]+image[8873]+image[8874]+image[8888]+image[8889]+image[8890]+image[8891]+image[8892]+image[8893]+image[8894]+image[8895]+image[8896]+image[8897]+image[8898]+image[8957]+image[8958]+image[8959]+image[8960]+image[8961]+image[8962]+image[8963]+image[8964]+image[8965]+image[8966]+image[8967]+image[8981]+image[8982]+image[8983]+image[8984]+image[8985]+image[8986]+image[8987]+image[9001]+image[9002]+image[9003]+image[9004]+image[9005]+image[9006]+image[9007]+image[9008]+image[9009]+image[9010]+image[9011]+image[9070]+image[9071]+image[9072]+image[9073]+image[9074]+image[9075]+image[9076]+image[9077]+image[9078]+image[9079]+image[9080]+image[9094]+image[9095]+image[9096]+image[9097]+image[9098]+image[9099]+image[9100]+image[9114]+image[9115]+image[9116]+image[9117]+image[9118]+image[9119]+image[9120]+image[9121]+image[9122]+image[9123]+image[9124]+image[9184]+image[9185]+image[9186]+image[9187]+image[9188]+image[9189]+image[9190]+image[9191]+image[9192]+image[9193]+image[9207]+image[9208]+image[9209]+image[9210]+image[9211]+image[9212]+image[9213]+image[9227]+image[9228]+image[9229]+image[9230]+image[9231]+image[9232]+image[9233]+image[9234]+image[9235]+image[9236]+image[9298]+image[9299]+image[9300]+image[9301]+image[9302]+image[9303]+image[9304]+image[9305]+image[9306]+image[9320]+image[9321]+image[9322]+image[9323]+image[9324]+image[9325]+image[9326]+image[9340]+image[9341]+image[9342]+image[9343]+image[9344]+image[9345]+image[9346]+image[9347]+image[9348]+image[9412]+image[9413]+image[9414]+image[9415]+image[9416]+image[9417]+image[9418]+image[9419]+image[9433]+image[9434]+image[9435]+image[9436]+image[9437]+image[9438]+image[9439]+image[9453]+image[9454]+image[9455]+image[9456]+image[9457]+image[9458]+image[9459]+image[9460]+image[9546]+image[9547]+image[9548]+image[9549]+image[9550]+image[9551]+image[9552]+image[9659]+image[9660]+image[9661]+image[9662]+image[9663]+image[9664]+image[9665]+image[10541]+image[10542]+image[10543]+image[10544]+image[10545]+image[10546]+image[10547]+image[10585]+image[10586]+image[10587]+image[10588]+image[10589]+image[10590]+image[10591]+image[10655]+image[10656]+image[10657]+image[10658]+image[10659]+image[10660]+image[10661]+image[10697]+image[10698]+image[10699]+image[10700]+image[10701]+image[10702]+image[10703]+image[10769]+image[10770]+image[10771]+image[10772]+image[10773]+image[10774]+image[10775]+image[10809]+image[10810]+image[10811]+image[10812]+image[10813]+image[10814]+image[10815]+image[10883]+image[10884]+image[10885]+image[10886]+image[10887]+image[10888]+image[10922]+image[10923]+image[10924]+image[10925]+image[10926]+image[10927]+image[11569]+image[11570]+image[11596]+image[11597]+image[11682]+image[11683]+image[11684]+image[11708]+image[11709]+image[11710]+image[11795]+image[11796]+image[11797]+image[11798]+image[11820]+image[11821]+image[11822]+image[11823]+image[11908]+image[11909]+image[11910]+image[11911]+image[11933]+image[11934]+image[11935]+image[11936]+image[12021]+image[12022]+image[12023]+image[12024]+image[12046]+image[12047]+image[12048]+image[12049]+image[12135]+image[12136]+image[12137]+image[12159]+image[12160]+image[12161]+image[12249]+image[12250]+image[12272]+image[12273]+image[13609]+image[13610]+image[13611]+image[13612]+image[13613]+image[13614]+image[13615]+image[13616]+image[13617]+image[13618]+image[13619]+image[13620]+image[13621]+image[13622]+image[13623]+image[13624]+image[13625]+image[13722]+image[13723]+image[13724]+image[13725]+image[13726]+image[13727]+image[13728]+image[13729]+image[13730]+image[13731]+image[13732]+image[13733]+image[13734]+image[13735]+image[13736]+image[13737]+image[13738]+image[13837]+image[13838]+image[13839]+image[13840]+image[13841]+image[13842]+image[13843]+image[13844]+image[13845]+image[13846]+image[13847]+image[13848]+image[13849];
				confidence_BLK = (~image[4777])+(~image[4778])+(~image[4779])+(~image[4780])+(~image[4781])+(~image[4782])+(~image[4783])+(~image[4784])+(~image[4785])+(~image[4821])+(~image[4822])+(~image[4823])+(~image[4824])+(~image[4825])+(~image[4826])+(~image[4827])+(~image[4828])+(~image[4829])+(~image[4889])+(~image[4890])+(~image[4891])+(~image[4892])+(~image[4893])+(~image[4894])+(~image[4895])+(~image[4896])+(~image[4897])+(~image[4898])+(~image[4934])+(~image[4935])+(~image[4936])+(~image[4937])+(~image[4938])+(~image[4939])+(~image[4940])+(~image[4941])+(~image[4942])+(~image[4943])+(~image[5001])+(~image[5002])+(~image[5003])+(~image[5004])+(~image[5005])+(~image[5006])+(~image[5007])+(~image[5008])+(~image[5009])+(~image[5010])+(~image[5011])+(~image[5047])+(~image[5048])+(~image[5049])+(~image[5050])+(~image[5051])+(~image[5052])+(~image[5053])+(~image[5054])+(~image[5055])+(~image[5056])+(~image[5057])+(~image[5114])+(~image[5115])+(~image[5116])+(~image[5117])+(~image[5118])+(~image[5119])+(~image[5120])+(~image[5121])+(~image[5122])+(~image[5123])+(~image[5124])+(~image[5160])+(~image[5161])+(~image[5162])+(~image[5163])+(~image[5164])+(~image[5165])+(~image[5166])+(~image[5167])+(~image[5168])+(~image[5169])+(~image[5170])+(~image[5228])+(~image[5229])+(~image[5230])+(~image[5231])+(~image[5232])+(~image[5233])+(~image[5234])+(~image[5235])+(~image[5236])+(~image[5237])+(~image[5273])+(~image[5274])+(~image[5275])+(~image[5276])+(~image[5277])+(~image[5278])+(~image[5279])+(~image[5280])+(~image[5281])+(~image[5282])+(~image[5342])+(~image[5343])+(~image[5344])+(~image[5345])+(~image[5346])+(~image[5347])+(~image[5348])+(~image[5349])+(~image[5350])+(~image[5386])+(~image[5387])+(~image[5388])+(~image[5389])+(~image[5390])+(~image[5391])+(~image[5392])+(~image[5393])+(~image[5394])+(~image[6468])+(~image[6469])+(~image[6470])+(~image[6471])+(~image[6472])+(~image[6473])+(~image[6474])+(~image[6475])+(~image[6476])+(~image[6477])+(~image[6478])+(~image[6479])+(~image[6480])+(~image[6481])+(~image[6482])+(~image[6514])+(~image[6515])+(~image[6516])+(~image[6517])+(~image[6518])+(~image[6519])+(~image[6520])+(~image[6521])+(~image[6522])+(~image[6523])+(~image[6524])+(~image[6525])+(~image[6526])+(~image[6527])+(~image[6528])+(~image[6581])+(~image[6582])+(~image[6583])+(~image[6584])+(~image[6585])+(~image[6586])+(~image[6587])+(~image[6588])+(~image[6589])+(~image[6590])+(~image[6591])+(~image[6592])+(~image[6593])+(~image[6594])+(~image[6595])+(~image[6627])+(~image[6628])+(~image[6629])+(~image[6630])+(~image[6631])+(~image[6632])+(~image[6633])+(~image[6634])+(~image[6635])+(~image[6636])+(~image[6637])+(~image[6638])+(~image[6639])+(~image[6640])+(~image[6641])+(~image[6694])+(~image[6695])+(~image[6696])+(~image[6697])+(~image[6698])+(~image[6699])+(~image[6700])+(~image[6701])+(~image[6702])+(~image[6703])+(~image[6704])+(~image[6705])+(~image[6706])+(~image[6707])+(~image[6708])+(~image[6740])+(~image[6741])+(~image[6742])+(~image[6743])+(~image[6744])+(~image[6745])+(~image[6746])+(~image[6747])+(~image[6748])+(~image[6749])+(~image[6750])+(~image[6751])+(~image[6752])+(~image[6753])+(~image[6754])+(~image[6807])+(~image[6808])+(~image[6809])+(~image[6810])+(~image[6811])+(~image[6812])+(~image[6813])+(~image[6814])+(~image[6815])+(~image[6816])+(~image[6817])+(~image[6818])+(~image[6819])+(~image[6820])+(~image[6821])+(~image[6853])+(~image[6854])+(~image[6855])+(~image[6856])+(~image[6857])+(~image[6858])+(~image[6859])+(~image[6860])+(~image[6861])+(~image[6862])+(~image[6863])+(~image[6864])+(~image[6865])+(~image[6866])+(~image[6867])+(~image[6921])+(~image[6922])+(~image[6923])+(~image[6924])+(~image[6925])+(~image[6926])+(~image[6927])+(~image[6928])+(~image[6929])+(~image[6930])+(~image[6931])+(~image[6932])+(~image[6933])+(~image[6967])+(~image[6968])+(~image[6969])+(~image[6970])+(~image[6971])+(~image[6972])+(~image[6973])+(~image[6974])+(~image[6975])+(~image[6976])+(~image[6977])+(~image[6978])+(~image[6979])+(~image[7035])+(~image[7036])+(~image[7037])+(~image[7038])+(~image[7039])+(~image[7040])+(~image[7041])+(~image[7042])+(~image[7043])+(~image[7044])+(~image[7045])+(~image[7081])+(~image[7082])+(~image[7083])+(~image[7084])+(~image[7085])+(~image[7086])+(~image[7087])+(~image[7088])+(~image[7089])+(~image[7090])+(~image[7091])+(~image[10334])+(~image[10335])+(~image[10336])+(~image[10337])+(~image[10338])+(~image[10339])+(~image[10340])+(~image[10341])+(~image[10342])+(~image[10343])+(~image[10344])+(~image[10345])+(~image[10346])+(~image[10446])+(~image[10447])+(~image[10448])+(~image[10449])+(~image[10450])+(~image[10451])+(~image[10452])+(~image[10453])+(~image[10454])+(~image[10455])+(~image[10456])+(~image[10457])+(~image[10458])+(~image[10459])+(~image[10460])+(~image[10559])+(~image[10560])+(~image[10561])+(~image[10562])+(~image[10563])+(~image[10564])+(~image[10565])+(~image[10566])+(~image[10567])+(~image[10568])+(~image[10569])+(~image[10570])+(~image[10571])+(~image[10572])+(~image[10573])+(~image[10673])+(~image[10674])+(~image[10675])+(~image[10676])+(~image[10677])+(~image[10678])+(~image[10679])+(~image[10680])+(~image[10681])+(~image[10682])+(~image[10683])+(~image[10684])+(~image[10685])+(~image[12816])+(~image[12817])+(~image[12818])+(~image[12819])+(~image[12820])+(~image[12821])+(~image[12822])+(~image[12823])+(~image[12824])+(~image[12825])+(~image[12826])+(~image[12827])+(~image[12828])+(~image[12829])+(~image[12830])+(~image[12831])+(~image[12832])+(~image[12833])+(~image[12834])+(~image[12835])+(~image[12836])+(~image[12929])+(~image[12930])+(~image[12931])+(~image[12932])+(~image[12933])+(~image[12934])+(~image[12935])+(~image[12936])+(~image[12937])+(~image[12938])+(~image[12939])+(~image[12940])+(~image[12941])+(~image[12942])+(~image[12943])+(~image[12944])+(~image[12945])+(~image[12946])+(~image[12947])+(~image[12948])+(~image[12949])+(~image[13035])+(~image[13036])+(~image[13037])+(~image[13038])+(~image[13039])+(~image[13040])+(~image[13041])+(~image[13042])+(~image[13043])+(~image[13044])+(~image[13045])+(~image[13046])+(~image[13047])+(~image[13048])+(~image[13049])+(~image[13050])+(~image[13051])+(~image[13052])+(~image[13053])+(~image[13054])+(~image[13055])+(~image[13056])+(~image[13057])+(~image[13058])+(~image[13059])+(~image[13060])+(~image[13061])+(~image[13062])+(~image[13063])+(~image[13064])+(~image[13065])+(~image[13066])+(~image[13067])+(~image[13068])+(~image[13069])+(~image[13148])+(~image[13149])+(~image[13150])+(~image[13151])+(~image[13152])+(~image[13153])+(~image[13154])+(~image[13155])+(~image[13156])+(~image[13157])+(~image[13158])+(~image[13159])+(~image[13160])+(~image[13161])+(~image[13162])+(~image[13163])+(~image[13164])+(~image[13165])+(~image[13166])+(~image[13167])+(~image[13168])+(~image[13169])+(~image[13170])+(~image[13171])+(~image[13172])+(~image[13173])+(~image[13174])+(~image[13175])+(~image[13176])+(~image[13177])+(~image[13178])+(~image[13179])+(~image[13180])+(~image[13181])+(~image[13182])+(~image[14177])+(~image[14178])+(~image[14179])+(~image[14180])+(~image[14181])+(~image[14182])+(~image[14183])+(~image[14184])+(~image[14185])+(~image[14186])+(~image[14187])+(~image[14290])+(~image[14291])+(~image[14292])+(~image[14293])+(~image[14294])+(~image[14295])+(~image[14296])+(~image[14297])+(~image[14298])+(~image[14299])+(~image[14300])+(~image[14403])+(~image[14404])+(~image[14405])+(~image[14406])+(~image[14407])+(~image[14408])+(~image[14409])+(~image[14410])+(~image[14411])+(~image[14412])+(~image[14413])+(~image[14516])+(~image[14517])+(~image[14518])+(~image[14519])+(~image[14520])+(~image[14521])+(~image[14522])+(~image[14523])+(~image[14524])+(~image[14525])+(~image[14526])+(~image[14629])+(~image[14630])+(~image[14631])+(~image[14632])+(~image[14633])+(~image[14634])+(~image[14635])+(~image[14636])+(~image[14637])+(~image[14638])+(~image[14639]);
				done=1'b1;
				end
			default: ;
		endcase	
	end

						  
endmodule 
