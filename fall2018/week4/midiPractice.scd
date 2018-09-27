s.option.memSize = 81920;
ServerOptions

MIDIClient.init;
MIDIIn.connectAll;

MIDIdef.noteOn( \noteon, {
	arg vel, nn, chan, src;
	"vel: ".post; vel.postln;
	"nn: ".post; nn.postln;
	"chan: ".post; chan.postln;
	"src: ".post; src.postln;
} );

~notes = Array.newClear(128);

MIDIdef.noteOn( \noteon, {
	arg vel, nn, chan, src;
	~notes[nn] = Synth(\wonder, [
		\pitch, nn,
		\amp, vel.linlin( 0, 127, 0.0, 1.0 ),
		\gate, 1
	] );
} );

MIDIdef.noteOff( \noteoff, {
	arg vel, nn;
	~notes[nn].set(\gate, 0);
} );

	SynthDef( \synthbass,{
	arg gate=1, atk=0.01, rel=0.07, crv= -6,
	fatk=0.01, fdky=0.14, fsus=0.1, frel=0.07, fcrv= 0,
	ffrq1=1800, rq1=0.6, dky=0, sus=1;
	var freq1, osc1, vol, amp, env,
	osc2, osc3, freq2, freq3,
	sig, pitch, fenv, sigR;
	pitch = \pitch.kr(60, 0.017);
	freq1 = pitch.midicps;
	freq2 = (pitch+0.06).midicps;
	freq3 = (pitch-12).midicps;
	amp = \amp.kr(0.85, 0.040);
	env = EnvGen.ar( Env.adsr(atk, dky, sus, rel, curve:crv), gate, doneAction:2);
	fenv = EnvGen.ar( Env.adsr(fatk, fdky, fsus, frel, curve:fcrv), gate);
	osc1 = SawDPW.ar(freq1);
	osc2 = SawDPW.ar(freq2);
	osc3 = SinOsc.ar(freq3);
	sig = Mix.ar([osc1, osc2, osc3]);
	sig = RLPF.ar( sig, (ffrq1*fenv)+80, rq1 );
	sig = sig.softclip;
	sigR = DelayC.ar(sig, 0.2, 0.03);
	Out.ar(0, [sig, sigR]*env*amp);
}).add;