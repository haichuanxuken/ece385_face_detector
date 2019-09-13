module	VGA_Controller(	//	Host Side
						drawrec,		//5-bit input from calculation module to determine which rectangle to draw
						iRed,
						iGreen,
						iBlue,
						oRequest,
						//	VGA Side
						oVGA_R, // the outmost signals
						oVGA_G,
						oVGA_B,
						oVGA_H_SYNC,
						oVGA_V_SYNC,
						oVGA_SYNC,
						oVGA_BLANK,
						oVGA_CLOCK,
						//	Control Signal
						iCLK,
						iRST_N,
						H_Cont, //output
						V_Cont,	//output
						
						// for debugging
						//image,
						//cansend
						);

`include "VGA_Param.h"

input		[4:0]	drawrec;				//5-bit input from calculation module to determine which rectangle to draw

//	Host Side
input		[9:0]	iRed;
input		[9:0]	iGreen;
input		[9:0]	iBlue;
output	reg			oRequest;
//	VGA Side
output	reg	[9:0]	oVGA_R;
output	reg 	[9:0]	oVGA_G;
output	reg	[9:0]	oVGA_B;
output	reg			oVGA_H_SYNC;
output	reg			oVGA_V_SYNC;
output				oVGA_SYNC;
output				oVGA_BLANK;
output				oVGA_CLOCK;
//	Control Signal
input				iCLK;
input				iRST_N;

//	Internal Registers and Wires
output	reg		[9:0]		H_Cont;		//changed to output to the frameinput module
output	reg		[9:0]		V_Cont;		//changed to output to the frameinput module

// for debuging
//input [0:44999] image;
//input cansend;

reg		[9:0]		Cur_Color_R;
reg		[9:0]		Cur_Color_G;
reg		[9:0]		Cur_Color_B;
wire				mCursor_EN;
wire				mRed_EN;
wire				mGreen_EN;
wire				mBlue_EN;

wire		[9:0]		internalR;		//added not-middle rectangle output signal
wire		[9:0]		internalG;
wire		[9:0]		internalB;

wire		outerframe;					//bool logic for the fixed frame and five possible rectangles
wire		frame1;
wire		frame2;
wire		frame3;
wire		frame4;
wire		frame5;

assign	outerframe		=		(((H_Cont==X_START+170 || H_Cont==X_START+171 || H_Cont==X_START+468 || H_Cont==X_START+469) && (V_Cont>=Y_START+165 && V_Cont<=Y_START+314)) || ((V_Cont==Y_START+165 || V_Cont==Y_START+166 || V_Cont==Y_START+313 || V_Cont==Y_START+314) && (H_Cont>=X_START+170 && H_Cont<=X_START+469)))
								?		1	:	0;
assign	frame1			= 		(((H_Cont==X_START+174 || H_Cont==X_START+269) && (V_Cont>=Y_START+169 && V_Cont<=Y_START+310)) || ((V_Cont==Y_START+169 || V_Cont==Y_START+310) && (H_Cont>=X_START+174 && H_Cont<=X_START+269)))
								?		1	:	0;
assign	frame3			= 		(((H_Cont==X_START+272 || H_Cont==X_START+367) && (V_Cont>=Y_START+169 && V_Cont<=Y_START+310)) || ((V_Cont==Y_START+169 || V_Cont==Y_START+310) && (H_Cont>=X_START+272 && H_Cont<=X_START+367)))
								?		1	:	0;
assign	frame5			= 		(((H_Cont==X_START+370 || H_Cont==X_START+465) && (V_Cont>=Y_START+169 && V_Cont<=Y_START+310)) || ((V_Cont==Y_START+169 || V_Cont==Y_START+310) && (H_Cont>=X_START+370 && H_Cont<=X_START+465)))
								?		1	:	0;
assign	frame2			= 		(((H_Cont==X_START+223 || H_Cont==X_START+318) && (V_Cont>=Y_START+169 && V_Cont<=Y_START+310)) || ((V_Cont==Y_START+169 || V_Cont==Y_START+310) && (H_Cont>=X_START+223 && H_Cont<=X_START+318)))
								?		1	:	0;
assign	frame4			= 		(((H_Cont==X_START+321 || H_Cont==X_START+416) && (V_Cont>=Y_START+169 && V_Cont<=Y_START+310)) || ((V_Cont==Y_START+169 || V_Cont==Y_START+310) && (H_Cont>=X_START+321 && H_Cont<=X_START+416)))
								?		1	:	0;

assign	oVGA_BLANK	=	oVGA_H_SYNC & oVGA_V_SYNC;
assign	oVGA_SYNC	=	1'b0;
assign	oVGA_CLOCK	=	iCLK;

assign	internalR	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	(iBlue > 10'b0110000000 ? 10'b1111111111 : 10'b0)	:	0;
assign	internalG	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT ) //(iBlue > 10'b0110000000 ? 10'b1111111111 : 10'b0)
						?	(iBlue > 10'b0110000000 ? 10'b1111111111 : 10'b0)	:	0;
assign	internalB	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	(iBlue > 10'b0110000000 ? 10'b1111111111 : 10'b0)	:	0;

always@( * )
begin

	
	case (drawrec)
		5'b10000:
			begin
			oVGA_R	=	(outerframe || frame1)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame1)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame1)
			?	10'b0111111111	:	internalB;
			end
		5'b01000:
			begin
			oVGA_R	=	(outerframe || frame2)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame2)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame2)
			?	10'b0111111111	:	internalB;
			end
		5'b00100:
			begin
			oVGA_R	=	(outerframe || frame3)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame3)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame3)
			?	10'b0111111111	:	internalB;
			end
		5'b00010:
			begin
			oVGA_R	=	(outerframe || frame4)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame4)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame4)
			?	10'b0111111111	:	internalB;
			end
		5'b00001:
			begin
			oVGA_R	=	(outerframe || frame5)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame5)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame5)
			?	10'b0111111111	:	internalB;
			end
		
		5'b11000:
			begin
			oVGA_R	=	(outerframe || frame2)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame2)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame2)
			?	10'b0111111111	:	internalB;
			end
		5'b10100:
			begin
			oVGA_R	=	(outerframe || frame1 ||frame3)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame1 ||frame3)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame1 ||frame3)
			?	10'b0111111111	:	internalB;
			end
		5'b10010:
			begin
			oVGA_R	=	(outerframe || frame1 ||frame4)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame1 ||frame4)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame1 ||frame4)
			?	10'b0111111111	:	internalB;
			end
		5'b10001:
			begin
			oVGA_R	=	(outerframe || frame1 ||frame5)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame1 ||frame5)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame1 ||frame5)
			?	10'b0111111111	:	internalB;
			end
		5'b01100:
			begin
			oVGA_R	=	(outerframe || frame3)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame3)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame3)
			?	10'b0111111111	:	internalB;
			end
		5'b01010:
			begin
			oVGA_R	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalB;
			end
		5'b01001:
			begin
			oVGA_R	=	(outerframe || frame2 ||frame5)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame2 ||frame5)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame2 ||frame5)
			?	10'b0111111111	:	internalB;
			end
		5'b00110:
			begin
			oVGA_R	=	(outerframe || frame3)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame3)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame3)
			?	10'b0111111111	:	internalB;
			end
		5'b00101:
			begin
			oVGA_R	=	(outerframe || frame3 ||frame5)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame3 ||frame5)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame3 ||frame5)
			?	10'b0111111111	:	internalB;
			end
		5'b00011:
			begin
			oVGA_R	=	(outerframe || frame4)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame4)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame4)
			?	10'b0111111111	:	internalB;
			end
		
		5'b11100:
			begin
			oVGA_R	=	(outerframe || frame1 ||frame3)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame1 ||frame3)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame1 ||frame3)
			?	10'b0111111111	:	internalB;
			end
		5'b11010:
			begin
			oVGA_R	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalB;
			end
		5'b11001:
			begin
			oVGA_R	=	(outerframe || frame2 ||frame5)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame2 ||frame5)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame2 ||frame5)
			?	10'b0111111111	:	internalB;
			end
		5'b10110:
			begin
			oVGA_R	=	(outerframe || frame1 ||frame3)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame1 ||frame3)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame1 ||frame3)
			?	10'b0111111111	:	internalB;
			end
		5'b10101:
			begin
			oVGA_R	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalB;
			end
		5'b10011:
			begin
			oVGA_R	=	(outerframe || frame1 ||frame4)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame1 ||frame4)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame1 ||frame4)
			?	10'b0111111111	:	internalB;
			end
		5'b01110:
			begin
			oVGA_R	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalB;
			end
		5'b01101:
			begin
			oVGA_R	=	(outerframe || frame3 ||frame5)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame3 ||frame5)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame3 ||frame5)
			?	10'b0111111111	:	internalB;
			end
		5'b01011:
			begin
			oVGA_R	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalB;
			end
		5'b00111:
			begin
			oVGA_R	=	(outerframe || frame3 ||frame5)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame3 ||frame5)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame3 ||frame5)
			?	10'b0111111111	:	internalB;
			end
			
		5'b11110:
			begin
			oVGA_R	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalB;
			end
		5'b11101:
			begin
			oVGA_R	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalB;
			end
		5'b11011:
			begin
			oVGA_R	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalB;
			end
		5'b10111:
			begin
			oVGA_R	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalB;
			end
		5'b01111:
			begin
			oVGA_R	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame2 ||frame4)
			?	10'b0111111111	:	internalB;
			end
		
		5'b11111:
			begin
			oVGA_R	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe || frame1 || frame3 ||frame5)
			?	10'b0111111111	:	internalB;
			end
			
		default:
			begin
			oVGA_R	=	(outerframe)
			?	10'b0111111111	:	internalR;
			oVGA_G	=	(outerframe)
			?	10'b0111111111	:	internalG;
			oVGA_B	=	(outerframe)
			?	10'b0111111111	:	internalB;
			end
	endcase

	
//	if (H_Cont>=X_START 	&& H_Cont<=X_START+300 && V_Cont>=Y_START 	&& V_Cont<=Y_START+150 )
//		begin
//			oVGA_R=image[(H_Cont-X_START)+300*(V_Cont-Y_START)] ? 10'b1111111111 : 10'b0;
//			oVGA_G=image[(H_Cont-X_START)+300*(V_Cont-Y_START)] ? 10'b1111111111 : 10'b0;
//			oVGA_B=image[(H_Cont-X_START)+300*(V_Cont-Y_START)] ? 10'b1111111111 : 10'b0;
//			//oVGA_R=(!cansend) ? 10'b1111111111 : 10'b0;
//			//oVGA_G=(!cansend) ? 10'b1111111111 : 10'b0;
//			//oVGA_B=(!cansend) ? 10'b1111111111 : 10'b0;
//		end
		
//	if (H_Cont>=X_START 	&& H_Cont<=X_START+300 && V_Cont>=Y_START 	&& V_Cont<=Y_START+150 )
//	begin 
//	end	
end
				
		

	
	
// assign	oVGA_R	=	(outerframe || frame1 || frame2 || frame3 || frame4 || frame5)
// 						?	10'b1111111111	:	internalR;
// assign	oVGA_G	=	(outerframe || frame1 || frame2 || frame3 || frame4 || frame5)
// 						?	10'b1111111111	:	internalR;
// assign	oVGA_B	=	(outerframe || frame1 || frame2 || frame3 || frame4 || frame5)
// 						?	10'b1111111111	:	internalR;
						
// assign	oVGA_R	=	((((H_Cont>=X_START+170 && H_Cont<X_START+175) || (H_Cont>=X_START+465 && H_Cont<X_START+470)) && (V_Cont>=Y_START+165 && V_Cont<Y_START+315)) || (((V_Cont>=Y_START+165 && V_Cont<Y_START+170) || (V_Cont>=Y_START+310 && V_Cont<Y_START+315)) && (H_Cont>=X_START+170 && H_Cont<X_START+470)))		// change the center rectangle to pure white
// 						?	10'b1111111111	:	internalR;
// assign	oVGA_G	=	((((H_Cont>=X_START+170 && H_Cont<X_START+175) || (H_Cont>=X_START+465 && H_Cont<X_START+470)) && (V_Cont>=Y_START+165 && V_Cont<Y_START+315)) || (((V_Cont>=Y_START+165 && V_Cont<Y_START+170) || (V_Cont>=Y_START+310 && V_Cont<Y_START+315)) && (H_Cont>=X_START+170 && H_Cont<X_START+470)))
// 						?	10'b1111111111	:	internalG;
// assign	oVGA_B	=	((((H_Cont>=X_START+170 && H_Cont<X_START+175) || (H_Cont>=X_START+465 && H_Cont<X_START+470)) && (V_Cont>=Y_START+165 && V_Cont<Y_START+315)) || (((V_Cont>=Y_START+165 && V_Cont<Y_START+170) || (V_Cont>=Y_START+310 && V_Cont<Y_START+315)) && (H_Cont>=X_START+170 && H_Cont<X_START+470)))
// 						?	10'b1111111111	:	internalB;

// assign	oVGA_R	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
// 						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )
// 						?	iRed	:	0;
// assign	oVGA_G	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
// 						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )
// 						?	iGreen	:	0;
// assign	oVGA_B	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
// 						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )
// 						?	iBlue	:	0;
						

//	Pixel LUT Address Generator
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	oRequest	<=	0;
	else
	begin
		if(	H_Cont>=X_START-2 && H_Cont<X_START+H_SYNC_ACT-2 &&
			V_Cont>=Y_START && V_Cont<Y_START+V_SYNC_ACT )
		oRequest	<=	1;
		else
		oRequest	<=	0;
	end
end

//	H_Sync Generator, Ref. 25.175 MHz Clock
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		H_Cont		<=	0;
		oVGA_H_SYNC	<=	0;
	end
	else
	begin
		//	H_Sync Counter
		if( H_Cont < H_SYNC_TOTAL )
		H_Cont	<=	H_Cont+1;
		else
		H_Cont	<=	0;
		//	H_Sync Generator
		if( H_Cont < H_SYNC_CYC )
		oVGA_H_SYNC	<=	0;
		else
		oVGA_H_SYNC	<=	1;
	end
end

//	V_Sync Generator, Ref. H_Sync
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		V_Cont		<=	0;
		oVGA_V_SYNC	<=	0;
	end
	else
	begin
		//	When H_Sync Re-start
		if(H_Cont==0)
		begin
			//	V_Sync Counter
			if( V_Cont < V_SYNC_TOTAL )
			V_Cont	<=	V_Cont+1;
			else
			V_Cont	<=	0;
			//	V_Sync Generator
			if(	V_Cont < V_SYNC_CYC )
			oVGA_V_SYNC	<=	0;
			else
			oVGA_V_SYNC	<=	1;
		end
	end
end

endmodule

//module	VGA_Controller(	//	Host Side
//						iRed,
//						iGreen,
//						iBlue,
//						oRequest,
//						//	VGA Side
//						oVGA_R, // the outmost signals
//						oVGA_G,
//						oVGA_B,
//						oVGA_H_SYNC,
//						oVGA_V_SYNC,
//						oVGA_SYNC,
//						oVGA_BLANK,
//						oVGA_CLOCK,
//						//	Control Signal
//						iCLK,
//						iRST_N	);
//
//`include "VGA_Param.h"
//
////	Host Side
//input		[9:0]	iRed;
//input		[9:0]	iGreen;
//input		[9:0]	iBlue;
//output	reg			oRequest;
////	VGA Side
//output		[9:0]	oVGA_R;
//output		[9:0]	oVGA_G;
//output		[9:0]	oVGA_B;
//output	reg			oVGA_H_SYNC;
//output	reg			oVGA_V_SYNC;
//output				oVGA_SYNC;
//output				oVGA_BLANK;
//output				oVGA_CLOCK;
////	Control Signal
//input				iCLK;
//input				iRST_N;
//
////	Internal Registers and Wires
//reg		[9:0]		H_Cont;
//reg		[9:0]		V_Cont;
//reg		[9:0]		Cur_Color_R;
//reg		[9:0]		Cur_Color_G;
//reg		[9:0]		Cur_Color_B;
//wire				mCursor_EN;
//wire				mRed_EN;
//wire				mGreen_EN;
//wire				mBlue_EN;
//
//assign	oVGA_BLANK	=	oVGA_H_SYNC & oVGA_V_SYNC;
//assign	oVGA_SYNC	=	1'b0;
//assign	oVGA_CLOCK	=	iCLK;
//
//assign	oVGA_R	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
//						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )
//						?	iRed	:	0;
//assign	oVGA_G	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
//						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )
//						?	iGreen	:	0;
//assign	oVGA_B	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
//						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )
//						?	iBlue	:	0;
//
////	Pixel LUT Address Generator
//always@(posedge iCLK or negedge iRST_N)
//begin
//	if(!iRST_N)
//	oRequest	<=	0;
//	else
//	begin
//		if(	H_Cont>=X_START-2 && H_Cont<X_START+H_SYNC_ACT-2 &&
//			V_Cont>=Y_START && V_Cont<Y_START+V_SYNC_ACT )
//		oRequest	<=	1;
//		else
//		oRequest	<=	0;
//	end
//end
//
////	H_Sync Generator, Ref. 25.175 MHz Clock
//always@(posedge iCLK or negedge iRST_N)
//begin
//	if(!iRST_N)
//	begin
//		H_Cont		<=	0;
//		oVGA_H_SYNC	<=	0;
//	end
//	else
//	begin
//		//	H_Sync Counter
//		if( H_Cont < H_SYNC_TOTAL )
//		H_Cont	<=	H_Cont+1;
//		else
//		H_Cont	<=	0;
//		//	H_Sync Generator
//		if( H_Cont < H_SYNC_CYC )
//		oVGA_H_SYNC	<=	0;
//		else
//		oVGA_H_SYNC	<=	1;
//	end
//end
//
////	V_Sync Generator, Ref. H_Sync
//always@(posedge iCLK or negedge iRST_N)
//begin
//	if(!iRST_N)
//	begin
//		V_Cont		<=	0;
//		oVGA_V_SYNC	<=	0;
//	end
//	else
//	begin
//		//	When H_Sync Re-start
//		if(H_Cont==0)
//		begin
//			//	V_Sync Counter
//			if( V_Cont < V_SYNC_TOTAL )
//			V_Cont	<=	V_Cont+1;
//			else
//			V_Cont	<=	0;
//			//	V_Sync Generator
//			if(	V_Cont < V_SYNC_CYC )
//			oVGA_V_SYNC	<=	0;
//			else
//			oVGA_V_SYNC	<=	1;
//		end
//	end
//end
//
//endmodule