class_name Map extends Node

@onready var chunkHandler:ChunkHandler = $ChunkHandler

func _ready() -> void:
	chunkHandler.genPosRect(Vector2i(0,0),32)
