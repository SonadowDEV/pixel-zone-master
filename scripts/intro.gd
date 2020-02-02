extends Control
var scene
var config
var leaderboard = {
		'api_key' : "YZ7CY9acpN9NIZ9ebKXd43NO4FVCJFkR8rkF2cO4",
		"game_id": "PixelZone",
		"game_version": "0.9.1-beta1",
		"log_level": 1
	}
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/settings/lang.save", File.READ)
	var loaded_lang = parse_json(load_.get_line())
	TranslationServer.set_locale(str(loaded_lang))

func _ready():
#	ads.admob.showBanner()
	var conf = File.new()
#	if conf.file_exists('user://dlc.txt'):
#		ProjectSettings.load_resource_pack('user://dlc.pck')
#	ProjectSettings.save()

#	var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	var vconf = ConfigFile.new()
	
	if not conf.file_exists('user://456378r9w4iufuhj'):
		vconf.set_value("saves", "game_pass", "false")
		config = vconf.save(str(documents) + "/Pixel Zone/.data/settings/game.ini")
		conf.open('user://456378r9w4iufuhj', File.WRITE)
	OS.set_use_file_access_save_and_swap(true)
	var documents_dir = Directory.new()
	if not documents_dir.dir_exists("user://Custom Tiles/"):
		documents_dir.open('user://')
		documents_dir.make_dir('Custom Tiles')
	if not documents_dir.dir_exists(str(documents)+ "/Pixel Zone/.data"):
		documents_dir.open(str(documents)+ "/")
		documents_dir.make_dir("Pixel Zone")
		documents_dir.open(str(documents)+ "/Pixel Zone")
		documents_dir.make_dir(".data")
		documents_dir.open(str(documents)+ "/Pixel Zone/.data")
		documents_dir.make_dir("settings")
		documents_dir.make_dir("updates")
		documents_dir.open(str(documents)+ "/Pixel Zone/.data/updates")
		documents_dir.make_dir("config")
	if not documents_dir.dir_exists("user://logs/"):
		documents_dir.open('user://')
		documents_dir.make_dir('logs')
	if not documents_dir.dir_exists("user://other_saves/"):
		documents_dir.open('user://')
		documents_dir.make_dir('other_saves')
	if not documents_dir.dir_exists("user://saved_levels/"):
		documents_dir.open('user://')
		documents_dir.make_dir('saved_levels')
	if not documents_dir.dir_exists('user://auth/data/'):
		documents_dir.open('user://')
		documents_dir.make_dir('auth')
		documents_dir.open('user://auth/')
		documents_dir.make_dir('data')
	if not documents_dir.dir_exists("user://saves/"):
		documents_dir.open('user://')
		documents_dir.make_dir('saves')
		documents_dir.open('user://saves')
		documents_dir.make_dir('1')
		documents_dir.make_dir('2')
	_load()
	var config_ = ConfigFile.new()
	config_.set_value("updates", "current_engine version", str(Engine.get_version_info()))
	config_.save(str(documents) + "/Pixel Zone/.data/updates/config/config.ini")
	$AnimationPlayer.play("intro")

func _on_AnimationPlayer_animation_finished(anim_name):
	if not str(anim_name) == '':
		scene = get_tree().change_scene("res://scenes/gui_loader.tscn")
