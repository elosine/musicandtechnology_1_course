OSCdef( \osctest, {
	arg msg;
	msg.postln;
}, "/1/xy1" );

n = NetAddr("127.0.0.1", 57120);

n.sendMsg( "/osctest", 1, 2, 3, "fdsa" );