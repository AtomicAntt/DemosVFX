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
			
			# We also want to later add data to each vertex containing triangle
			# centers in CUSTOM0 for our shader. 
			#st.commit(new_mesh)
			
			var custom0: PackedColorArray = PackedColorArray()
			custom0.resize(vertices.size())
			
			for v_idx in range(0, vertices.size(), 3):
				var v0: Vector3 = vertices[v_idx]
				var v1: Vector3 = vertices[v_idx + 1]
				var v2: Vector3 = vertices[v_idx + 2]
				
				var center: Vector3 = (v0 + v1 + v2) / 3.0
				
				#var center_data: Color = Color(center.x, center.y, center.z, 1.0)
				#mdt.set_vertex_color(v0_idx, center_data)
				#mdt.set_vertex_color(v1_idx, center_data)
				#mdt.set_vertex_color(v2_idx, center_data)
				
				# Cursed but shall it work?
				var center_data: PackedFloat32Array = PackedFloat32Array([center.x, center.y, center.z, 1.0])
				mdt.set_vertex_weights(v0_idx, center_data)
				mdt.set_vertex_weights(v1_idx, center_data)
				mdt.set_vertex_weights(v2_idx, center_data)
			
		node.mesh = new_mesh
		
	for child in node.get_children():
		_process_node(child)
