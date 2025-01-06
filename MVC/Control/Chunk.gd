class_name Chunk extends Node3D

var neighborsNorth:Chunk
var neighborsEast:Chunk
var neighborsSouth:Chunk
var neighborsWest:Chunk

var height:Array = [-1,-1,-1,-1]

func setNeighbors(neighborsArray:Array):
	neighborsNorth = neighborsArray[0]
	neighborsEast = neighborsArray[1]
	neighborsSouth = neighborsArray[2]
	neighborsWest = neighborsArray[3]
	
func genChunk():
	if(height[0] == -1):
		height[0] = randf_range(0,1)
		if(neighborsNorth != null):neighborsNorth.height[3] = height[0]
		if(neighborsWest != null):neighborsWest.height[1] = height[0]
	
	if(height[1] == -1):
		height[1] = randf_range(0,2)
		if(neighborsNorth != null):neighborsNorth.height[2] = height[1]
		if(neighborsEast != null):neighborsEast.height[0] = height[1]
		
	if(height[2] == -1):
		height[2] = randf_range(0,1)
		if(neighborsSouth != null):neighborsSouth.height[1] = height[2]
		if(neighborsEast != null):neighborsEast.height[3] = height[2]
		
	if(height[3] == -1):
		height[3] = randf_range(0,2)
		if(neighborsSouth != null):neighborsSouth.height[0] = height[3]
		if(neighborsWest != null):neighborsWest.height[2] = height[3]
	
	var mesh:MeshInstance3D = MeshInstance3D.new()
	
	var surface_tool = SurfaceTool.new();
 
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES);
	
	surface_tool.set_uv(Vector2(0,0))
	surface_tool.set_normal(Vector3(0, 0, 1))
	surface_tool.add_vertex(Vector3(-1, height[0], 1));
	
	surface_tool.set_uv(Vector2(0,0))
	surface_tool.set_normal(Vector3(0, 0, 1))
	surface_tool.add_vertex(Vector3(1, height[1], 1));
	
	surface_tool.set_uv(Vector2(0,0))
	surface_tool.set_normal(Vector3(0, 0, 1))
	surface_tool.add_vertex(Vector3(1, height[2], -1));
	
	surface_tool.set_uv(Vector2(0,0))
	surface_tool.set_normal(Vector3(0, 0, 1))
	surface_tool.add_vertex(Vector3(-1, height[3], -1));
	
	surface_tool.add_index(0);
	surface_tool.add_index(2);
	surface_tool.add_index(1);
	
	surface_tool.add_index(0);
	surface_tool.add_index(3);
	surface_tool.add_index(2);
	
	surface_tool.generate_normals()
	
	mesh.mesh = surface_tool.commit()
	
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(.2, .8, .2) # Rouge
	mesh.material_override = material
	
	add_child(mesh)
