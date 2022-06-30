class_name QVoxelBlock, "res://addons/qvoxel/textures/qvoxel.png"
extends Resource

const FULL_SIDE_LEFT = 1
const FULL_SIDE_RIGHT = 2
const FULL_SIDE_TOP = 4
const FULL_SIDE_BOTTOM = 8
const FULL_SIDE_FRONT = 16
const FULL_SIDE_BACK = 32
const FULL_SIDE_ALL = FULL_SIDE_LEFT | FULL_SIDE_RIGHT | FULL_SIDE_TOP | FULL_SIDE_BOTTOM | FULL_SIDE_FRONT | FULL_SIDE_BACK

export var id := ""
export(int, FLAGS, "Left", "Right", "Top", "Bottom", "Front", "Back") var full_side

#func mesh():
#	pass
