Platform.userExtensionDir


SynthDef( \apple, {} ).add;
SynthDef( \apple, {
	arg pitch=60;
	var sig;
	sig = SinOsc.ar( pitch.midicps  );
	Out.ar(0, sig);
} ).add;

a = Synth(\apple);

Pbind(
	 \instrument, \apple,
	\pitch, Pseq( [60, 64, 67], 5 ),
	\dur, Pseq( [0.5], inf )
).play;