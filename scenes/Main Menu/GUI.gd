extends Control
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var desktop = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
var dcim = OS.get_system_dir(OS.SYSTEM_DIR_DCIM)
var downloads = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)
var movies = OS.get_system_dir(OS.SYSTEM_DIR_MOVIES)
var music = OS.get_system_dir(OS.SYSTEM_DIR_MUSIC)
var load_mod = "false"
var mod_temp
func _on_Play_pressed():
	$AnimationPlayer.play("new")
func _ready():
	var beta = File.new()
	beta.open(str(documents)+ "/Pixel Zone/.data/settings/beta.save", File.READ)
	var loaded = bool(str(beta.get_line()))
	$TextureRect/VBoxContainer/Update.set_visible(loaded)
func _on_Quit_pressed():
	get_tree().quit()

func _process(delta):
	$TextureRect/Label.set_text("Downloaded " + str($HTTPRequest.get_downloaded_bytes()) + " bytes of " + str($HTTPRequest.get_body_size()) + " bytes (" + (str($HTTPRequest.get_downloaded_bytes()/($HTTPRequest.get_body_size()*(0.01)))) +" %)")
	
func _on_Play7_pressed():
	OS.shell_open("mailto:karoltomaszewskimusic@gmail.com;olo2tom@o2.pl;?subject=I Found a Bug in Pixel Zone")

func _on_Play6_pressed():
	$TextureRect/WindowDialog.popup_centered()

func _on_PP_pressed():
	$TextureRect/DownloadNot.popup_centered()
	$TextureRect/Label.show()
	globals.dlc_name == "3D DLC"
	$HTTPRequest.set_download_file("user://dlc_loops.pck")
	$HTTPRequest.request("https://github.com/MasterPolska123/pixel-zone-master/releases/download/v0.7.2.1.0/dlc_loops.pck")

func _on_Licenses_pressed():
	$TextureRect/Control._show()
func _on_Play8_pressed():
	get_tree().change_scene("res://dlcs/multi/lobby.tscn")



func _on_WindowDialog3_popup_hide():
	$TextureRect/WindowDialog2.hide()

func _on_close_pressed():
	$TextureRect/WindowDialog2.hide()


func _on_ImportMod_pressed():
	$ModSelector.popup()




func _on_WindowDialog3_about_to_show():
	$TextureRect/WindowDialog2.hide()


func _on_Update_pressed():
	background_load.load_scene("res://scenes/ScoreBoardOnline.tscn")


func _on_VScrollBar_value_changed(value):
	$Control.set_position(Vector2(0, -(value*10)))


func _on_Timer_timeout():
	_on_Play_pressed()

func _on_ModSelector_file_selected(path):
	var mod = File.new()
	var mod_path = File.new()
	mod_path.open(str(documents) + "/Pixel Zone/.data/mod_path.save", File.WRITE)
	mod_path.store_line(path)
	mod_temp = path
	print(str(path))
	ProjectSettings.load_resource_pack(path)
	get_tree().change_scene("res://mod.tscn")

func _on_ModSelector_popup_hide():
	pass


func _on_ModSelector_about_to_show():
	pass


func _on_ConfirmationDialog_confirmed():
	$AnimationPlayer.play("new")

signal reload
func _on_TextureButton_pressed():
	globals.scene_path = 'res://scenes/players/player1/player.tscn'
	globals.selected_player = preload('res://scenes/players/player1/player.tscn').instance()
	$AnimationPlayer.play("new")
	globals._save()
	#create new save
#	var a = File.new()
#	a.open_encrypted_with_pass("user://save_data.1", File.WRITE, str(34567865))
#	a.store_line("1")
#	a.close()
#	a.open_encrypted_with_pass("user://save_data.2", File.WRITE, str(34567865))
#	a.store_line("1")
#	a.close()
#	var vconf = ConfigFile.new()
#	vconf.set_value("saves", "game_pass", "false")
#	vconf.save(str(documents) + "/Pixel Zone/.data/settings/game.ini")
#	emit_signal("reload")
#	get_tree().reload_current_scene()
func _on_TextureButton2_pressed():
	globals.scene_path = 'res://scenes/players/player2/player2.tscn'
	globals.selected_player = preload('res://scenes/players/player2/player2.tscn').instance()
	$AnimationPlayer.play("new")
	globals._save()
	#create new save
#	var a = File.new()
#	a.open_encrypted_with_pass("user://save_data.1", File.WRITE, str(34567865))
#	a.store_line("0")
#	a.close()
#	a.open_encrypted_with_pass("user://save_data.2", File.WRITE, str(34567865))
#	a.store_line("0")
#	a.close()
#	var vconf = ConfigFile.new()
#	vconf.set_value("saves", "game_pass", "false")
#	vconf.save(str(documents) + "/Pixel Zone/.data/settings/game.ini")
#	emit_signal("reload")
#	get_tree().reload_current_scene()
func _on_Play5_pressed():
	$TextureRect/PopupPanel.popup_centered()


func _on_LoadGame2_pressed():
	OS.shell_open('https://masterpolska123.github.io/home/faq/index.html')
