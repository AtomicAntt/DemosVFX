@tool
extends EditorScenePostImport

func _post_import(scene: Node) -> Node:
	_process_node(scene)
	return scene

func _process_node(node: Node):
	if node is MeshInstance3D and node.mesh != null:
		var st = SurfaceTool.new()
		var new_mesh = ArrayMesh.new()
		
		# Rebuild every surface (material slot) of the mesh
		for i in range(node.mesh.get_surface_count()):
			st.create_from(node.mesh, i)
			st.deindex()
			st.commit(new_mesh)
			
		# Overwrite the imported mesh with our de-indexed version
		node.mesh = new_mesh
		
	# Recursively check all child nodes in the imported scene
	for child in node.get_children():
		_process_node(child)
