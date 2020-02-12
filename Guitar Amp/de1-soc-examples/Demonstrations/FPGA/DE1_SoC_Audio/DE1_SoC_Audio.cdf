/* Quartus Prime Version 18.0.0 Build 614 04/24/2018 SJ Standard Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(SOCVHPS) MfrSpec(OpMask(0));
	P ActionCode(Cfg)
		Device PartName(5CSEMA5F31) Path("C:/Guitar Amp/de1-soc-examples/Demonstrations/FPGA/DE1_SoC_Audio/") File("DE1_SoC_Audio.sof") MfrSpec(OpMask(1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
