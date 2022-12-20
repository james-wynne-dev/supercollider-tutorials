s.boot;
s.quit;

// --- Adding and removing buffers ---

~b0 = Buffer.read(s, "C:/Projects/PersonalLearning/SuperCollider/Samples/singing_bowl_1.wav");
~b0.play;
// Clear contents but not remove it from the server
~b0.zero;
// Read into existing buffer
~b0.read("C:/Projects/PersonalLearning/SuperCollider/Samples/singing_bowl_1.wav");
// Remove buffer from the server
~b0.free;
// Remove all buffers
Buffer.freeAll;

// --- Buffer contents ---
~b1 = Buffer.read(s, "C:/Projects/PersonalLearning/SuperCollider/Samples/singing_bowl_long_1.wav");
// .numFrames - length of buffer
// .numChannels - audio channels, stereo = 2
// the number of samples = frames * channels
~b1.play;
~b1.numChannels * ~b1.numFrames;
~b1.duration;
~b1.numChannels;

// Reading specific channels of an audio file, channel number starts from 0
~b2 = Buffer.readChannel(s, "C:/Projects/PersonalLearning/SuperCollider/Samples/singing_bowl_long_1.wav", channels: [1]);

// Buffer numbers (bufnum)
// Each buffer on the server is allocated a number
~b2.bufnum;

// Buffer sample rate - the rate at which the audio was recorded
// query gets a summary of the information of the buffer contents
~b2.query;

// Use the 3rd and 4th arguments to read in part of a sound file
~b3 = Buffer.read(
	s,
	"C:/Projects/PersonalLearning/SuperCollider/Samples/singing_bowl_long_1.wav",
	0,
	3279070);
~b3.numFrames;

// Load a collection of buffers
~singingBowls = List.new;
~folder = PathName.new("C:/Projects/PersonalLearning/SuperCollider/Samples");
~folder.entries;
~folder.entries.do({
	arg path;
	~singingBowls.add(Buffer.readChannel(s, path.fullPath, channels:[0]));
});
~singingBowls.postln;
~singingBowls[0].play;

// PlayBuf
// Use BufRateScale is used to scale the sample playback rate to match
// the server sample rate
// Use trigger and start to cause PlayBuf to go back to the start position
// If doneAction is 2, the Buffer reaches the end and free itself you can't retrigger
// If loop is set to 1 then PlayBuf ignores doneAction loops back to the start
(
SynthDef.new(\playBuf, {
	arg amp=1, out=0, buf, rate=1, t_trig=1, start=0;
	var sig;
	sig = PlayBuf.ar(
		1,
		buf,
		BufRateScale.kr(buf) * rate,
		t_trig,
		start,
		doneAction:2);
	Out.ar(out, sig);
}).add;
)

x = Synth.new(\playBuf, [\buf, ~singingBowls[0], \rate, 0.5]);
x.set(\t_trig, 1);





