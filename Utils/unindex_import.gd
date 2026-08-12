@tool
extends EditorScenePostImport

func _post_import(scene: Node) -> Node:
	_process_node(scene)
	return scene

func _process_node(node: Node):
	if node is MeshInstance3D and node.mesh != null:
		node = node as MeshInstance3D
		var st = SurfaceTool.new()
		var mdt = MeshDataTool.new()
		var new_mesh = ArrayMesh.new()
		
		for i in range(node.mesh.get_surface_count()):
			var node_mesh: Mesh = node.mesh
			var material = node_mesh.surface_get_material(i)
			mdt.create_from_surface(node_mesh, i)
			
			st.begin(Mesh.PRIMITIVE_TRIANGLES)
			st.set_custom_format(0, SurfaceTool.CUSTOM_RGBA_FLOAT)
			
			if material:
				st.set_material(material)
			
			for face_idx in mdt.get_face_count():
				var v0_idx: int = mdt.get_face_vertex(face_idx, 0)
				var v1_idx: int = mdt.get_face_vertex(face_idx, 1)
				var v2_idx: int = mdt.get_face_vertex(face_idx, 2)
				
				var v0: Vector3 = mdt.get_vertex(v0_idx)
				var v1: Vector3 = mdt.get_vertex(v1_idx)
				var v2: Vector3 = mdt.get_vertex(v2_idx)
				
				var center: Vector3 = (v0 + v1 + v2) / 3.0
				var center_data: Color = Color(center.x, center.y, center.z, 1.0)
				
				# Vertex 0
				st.set_normal(mdt.get_vertex_normal(v0_idx))
				st.set_uv(mdt.get_vertex_uv(v0_idx))
				st.set_custom(0, center_data)
				st.add_vertex(v0)
				# Vertex 1
				st.set_normal(mdt.get_vertex_normal(v1_idx))
				st.set_uv(mdt.get_vertex_uv(v1_idx))
				st.set_custom(0, center_data)
				st.add_vertex(v1)
				# Vertex 2
				st.set_normal(mdt.get_vertex_normal(v2_idx))
				st.set_uv(mdt.get_vertex_uv(v2_idx))
				st.set_custom(0, center_data)
				st.add_vertex(v2)
			
			st.generate_normals()
			st.generate_tangents()
			st.commit(new_mesh)
		
		node.mesh = new_mesh
		
	for child in node.get_children():
		_process_node(child)
