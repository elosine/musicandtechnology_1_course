b = Buffer.read(s, "/Users/yangj14/Documents/GitHub/scLiveCoding/scalewaiter/samples/glassbreak.wav");

c = Buffer.read(s, "/Users/yangj14/Documents/GitHub/scLiveCoding/scalewaiter/samples/typing.wav");

SynthDef( \sampy, {
	arg buf, rate=1, gate=1, loop=0, amp=0.85;
	var sig;
	sig = PlayBuf.ar( 1, buf, rate, gate, loop:loop, doneAction:2);
	Out.ar( 0, sig*amp );
} ).add;

a = Synth(\sampy, [\buf, b] );

OSCdef( \playsamp, {
	arg msg;
	var sampnum = msg[1].asInteger;
	Synth(\sampy, [\buf, sampnum] );
}, "/button1" );

n = NetAddr("127.0.0.1", 57120);

n.sendMsg( "/button1", b.bufnum );

BPF.ar(sig, 3000, rq) * 12.dbamp;