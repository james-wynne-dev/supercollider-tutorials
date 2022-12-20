~b2 = Buffer.readChannel(s, "C:/Projects/PersonalLearning/SuperCollider/Samples/singing_bowl_long_1.wav", channels: [1]);

(
SynthDef.new(\grainBuf, {
	arg amp=0.2, buf;
	var sig;
	sig = GrainBuf.ar(
		2,              // numChannels
		Impulse.ar(10), // trigger
		0.2,            // duration
		buf,            // buffer number
		0.5,            // rate
		0.1,            // buffer playback position
		4,              // interpolation
		0.5,            // pan (if > 1 channels)
		-1,             // envbufnum (-1 is built in hanning window)
		512,            // max grains
		amp);           // amplitude
	Out.ar(0, sig);
	);
}).add;
)