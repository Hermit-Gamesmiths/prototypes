@tool
extends EditorPlugin

var button_collapse : Button
var button_expand : Button

func _enter_tree():
	# Create Collapse Button
	button_collapse = Button.new()
	button_collapse.text = "Collapse All"
	button_collapse.connect("pressed", Callable(self, "_on_button_collapse_pressed"))
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, button_collapse)
	button_collapse.icon = get_editor_interface().get_base_control().get_icon("Collapse", "EditorIcons")

	# Create Expand Button
	button_expand = Button.new()
	button_expand.text = "Expand All"
	button_expand.connect("pressed", Callable(self, "_on_button_expand_pressed"))
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, button_expand)
	button_expand.icon = get_editor_interface().get_base_control().get_icon("Expand", "EditorIcons")

func _exit_tree():
	if button_collapse:
		button_collapse.queue_free()
	if button_expand:
		button_expand.queue_free()

func _on_button_collapse_pressed():
	var scene_tree = get_tree()
	var current_scene = scene_tree.current_scene
	if current_scene:
		_collapse_all_children(current_scene)

func _on_button_expand_pressed():
	var scene_tree = get_tree()
	var current_scene = scene_tree.current_scene
	if current_scene:
		_expand_all_children(current_scene)

func _collapse_all_children(node):
	for child in node.get_children():
		if child is Node:
			child.set_display_folded(true)
			_collapse_all_children(child)

func _expand_all_children(node):
	for child in node.get_children():
		if child is Node:
			child.set_display_folded(false)
			_expand_all_children(child)
