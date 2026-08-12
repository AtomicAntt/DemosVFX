@tool
extends EditorScenePostImport

func _post_import(scene: Node) -> Node:
	_process_node(scene)
	return scene

func _process_node(node: Node):
	if node is MeshInstance3D and node.mesh != null:
		node = node as MeshInstance3D
		var st = SurfaceTool.new()
		var new_mesh = ArrayMesh.new()
		
		for i in range(node.mesh.get_surface_count()):
			var node_mesh: Mesh = node.mesh
			
			#print(node.mesh.surface_get_material(i))
			st.create_from(node_mesh, i)
			
			# De-index mesh so that vertices are duplicated for each triangle
			# We want this so that the barycentric coordinate shaders can work.
			st.deindex()
			
			var arrays: Array = st.commit_to_arrays()
			var vertices: Array = arrays[Mesh.ARRAY_VERTEX]
			
			var custom0: PackedColorArray = PackedColorArray()
			custom0.resize(vertices.size())
			
			for v_idx in range(0, vertices.size(), 3):
				var v0: Vector3 = vertices[v_idx]
				var v1: Vector3 = vertices[v_idx + 1]
				var v2: Vector3 = vertices[v_idx + 2]
				
				var center: Vector3 = (v0 + v1 + v2) / 3.0
				
				var center_data: Color = Color(center.x, center.y, center.z, 1.0)
				
				custom0[v_idx] = center_data
				custom0[v_idx + 1] = center_data
				custom0[v_idx + 2] = center_data
			
			arrays[Mesh.ARRAY_CUSTOM0] = custom0
			
			new_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
			
		node.mesh = new_mesh
		
	for child in node.get_children():
		_process_node(child)
