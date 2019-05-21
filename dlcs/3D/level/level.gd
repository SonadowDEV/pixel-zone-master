extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	if (settings2.gi_quality == settings2.GI_QUALITY_HIGH):
		ProjectSettings["rendering/quality/voxel_cone_tracing/high_quality"]=true
	elif (settings2.gi_quality == settings2.GI_QUALITY_LOW):
		ProjectSettings["rendering/quality/voxel_cone_tracing/high_quality"]=false
	else:
		$GIProbe.hide()
		$refprobes.show()
		
	if (settings2.aa_quality == settings2.AA_8X):
		get_node("/root").msaa = Viewport.MSAA_8X
	elif (settings2.aa_quality == settings2.AA_4X):
		get_node("/root").msaa = Viewport.MSAA_4X
	elif (settings2.aa_quality == settings2.AA_2X):
		get_node("/root").msaa = Viewport.MSAA_2X
	else:
		get_node("/root").msaa = Viewport.MSAA_DISABLED
		
	if (settings2.ssao_quality == settings2.SSAO_QUALITY_HIGH):
		$WorldEnvironment.environment.ssao_quality = $WorldEnvironment.environment.SSAO_QUALITY_HIGH
	elif (settings2.ssao_quality == settings2.SSAO_QUALITY_LOW):
		$WorldEnvironment.environment.ssao_quality = $WorldEnvironment.environment.SSAO_QUALITY_LOW
	else:
		$WorldEnvironment.environment.ssao_enabled = false
		
	if (settings2.resolution == settings2.RESOLUTION_NATIVE):
		pass
	elif (settings2.resolution == settings2.RESOLUTION_1080):
		var minsize=Vector2( OS.window_size.x * 1080 / OS.window_size.y, 1080.0)
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP_HEIGHT,minsize)
	elif (settings2.resolution == settings2.RESOLUTION_720):
		var minsize=Vector2( OS.window_size.x * 720 / OS.window_size.y, 720.0)
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP_HEIGHT,minsize)
	elif (settings2.resolution == settings2.RESOLUTION_576):
		var minsize=Vector2( OS.window_size.x * 576 / OS.window_size.y, 576.0)
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP_HEIGHT,minsize)
		
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass