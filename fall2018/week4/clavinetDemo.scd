(
SynthDef(\clav, {
	arg hpf=1700, gate=1;
	var sig, hp, env, lpf, sigd;
	env = EnvGen.ar( Env.adsr( 0.01, 0, 1, 0.01), gate);
	lpf = TRand.kr(3500, 4500, gate); //4000
	sig = Pulse.ar( width:0.29 );
	sig = RHPF.ar( sig, TRand.kr(1300, 1800, gate) );
	sig = RLPF.ar(sig, lpf, 0.8);
	sigd = DelayC.ar( sig, 0.2, 0.06);
	sig = Decimator.ar( sig,  44100, 6);
	Out.ar(0, (sig+sigd)*env);
}).add;
)

{Pluck.ar(WhiteNoise.ar())}.play;
pitch
pitch = LFTri.ar( 0.1).range( 0.5.neg, 0.5) + pitch
pitch.midicps;

a = Synth(\clav);

a.set(\gate, 1);
a.set(\gate, 0);