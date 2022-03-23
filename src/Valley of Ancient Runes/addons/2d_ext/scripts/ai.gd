class_name Ext2DAI
extends Ext2DCreature

enum State {
	IDLE
	WANDER
	CHASE
}

var state: int = State.IDLE
