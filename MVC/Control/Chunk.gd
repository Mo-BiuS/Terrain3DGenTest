class_name Chunk extends Node3D


var neighbors:Array[Chunk]
var height:Array = [-1,-1,-1,-1]


func setNeighbors(neighborsArray:Array[Chunk]):
	neighbors = neighborsArray
	
func genChunk():
	var i = 1
	var minRange = randf_range(1,5);
	if(height[0] != -1):
		minRange+=height[0]
		i+=1
	if(height[1] != -1):
		minRange+=height[1]
		i+=1
	if(height[2] != -1):
		minRange+=height[2]
		i+=1
	if(height[3] != -1):
		minRange+=height[3]
		i+=1
	minRange/=i
	
	if(height[0] == -1):
		height[0] = randf_range(0,minRange)
		if(neighbors[7] != null):neighbors[7].height[1] = height[0]
		if(neighbors[0] != null):neighbors[0].height[2] = height[0]
		if(neighbors[1] != null):neighbors[1].height[3] = height[0]
	
	if(height[1] == -1):
		height[1] = randf_range(0,minRange)
		if(neighbors[1] != null):neighbors[1].height[2] = height[1]
		if(neighbors[2] != null):neighbors[2].height[3] = height[1]
		if(neighbors[3] != null):neighbors[3].height[0] = height[1]
		
	if(height[2] == -1):
		height[2] = randf_range(0,minRange)
		if(neighbors[3] != null):neighbors[3].height[3] = height[2]
		if(neighbors[4] != null):neighbors[4].height[0] = height[2]
		if(neighbors[5] != null):neighbors[5].height[1] = height[2]
		
	if(height[3] == -1):
		height[3] = randf_range(0,minRange)
		if(neighbors[5] != null):neighbors[5].height[0] = height[3]
		if(neighbors[6] != null):neighbors[6].height[1] = height[3]
		if(neighbors[7] != null):neighbors[7].height[2] = height[3]
	
	var mesh:MeshInstance3D = MeshInstance3D.new()
	
	var surface_tool = SurfaceTool.new();
 
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES);
	
	surface_tool.set_uv(Vector2(0,0))
	surface_tool.set_normal(Vector3(0, 0, 1))
	surface_tool.add_vertex(Vector3(-2, height[0], 2));
	
	surface_tool.set_uv(Vector2(0,0))
	surface_tool.set_normal(Vector3(0, 0, 1))
	surface_tool.add_vertex(Vector3(2, height[1], 2));
	
	surface_tool.set_uv(Vector2(0,0))
	surface_tool.set_normal(Vector3(0, 0, 1))
	surface_tool.add_vertex(Vector3(2, height[2], -2));
	
	surface_tool.set_uv(Vector2(0,0))
	surface_tool.set_normal(Vector3(0, 0, 1))
	surface_tool.add_vertex(Vector3(-2, height[3], -2));
	
	surface_tool.add_index(0);
	surface_tool.add_index(2);
	surface_tool.add_index(1);
	
	surface_tool.add_index(0);
	surface_tool.add_index(3);
	surface_tool.add_index(2);
	
	surface_tool.generate_normals()
	
	mesh.mesh = surface_tool.commit()
	
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(.2, randf_range(.8,1), .2)
	mesh.material_override = material
	
	add_child(mesh)
	
	mesh.create_convex_collision()
