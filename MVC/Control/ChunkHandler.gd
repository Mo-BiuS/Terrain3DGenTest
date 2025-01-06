class_name ChunkHandler extends Node3D

@onready var packedChunk = preload("res://MVC/Control/Chunk.tscn")

var chunkDict:Dictionary = {}

func genPosRect(pos:Vector2i,rect:int):
	for x in range(pos.x-rect/2, pos.x+rect/2+1):
		for y in range(pos.y-rect/2, pos.y+rect/2+1):
			var chunk:Chunk = packedChunk.instantiate()
			chunk.position = Vector3i(x,0,y)*2
			chunk.name = str(Vector2i(x,y))
			chunkDict[Vector2i(x,y)] = chunk
			add_child(chunk)
	for x in range(pos.x-rect/2, pos.x+rect/2+1):
		for y in range(pos.y-rect/2, pos.y+rect/2+1):
			chunkDict[Vector2i(x,y)].setNeighbors(getNeighbors(Vector2i(x,y)))
			chunkDict[Vector2i(x,y)].genChunk()

func getNeighbors(pos:Vector2i)->Array:
	var rep:Array
	var dir:Array = [pos-Vector2i(0,-1),pos-Vector2i(2,0),pos-Vector2i(0,1),pos-Vector2i(-1,0)]
	for i in dir:
		if(chunkDict.has(i)):rep.append(chunkDict.get(i))
		else:rep.append(null)
	return rep
	
