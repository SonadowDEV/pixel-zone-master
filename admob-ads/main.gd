extends Node2D
#onready var downloadserver = preload("res://bin/downloadserver.gdns").new()
#onready var gamesite = preload("res://bin/gamesite.gdns").new()
#onready var mainserver = preload("res://bin/mainserver.gdns").new()
var admob = null
var isReal = true
var isTop = true

export var banner_on_top:bool = true
export var child_directed:bool = false
export var is_personalized:bool = true
export(String, "G", "PG", "T", "MA") var max_ad_content_rate = "MA"
var adBannerId = "ca-app-pub-3142193952770678/7369767442" # [Replace with your Ad Unit ID and delete this message.]
var adInterstitialId = "ca-app-pub-3142193952770678/9337455234" # [Replace with your Ad Unit ID and delete this message.]
var adRewardedId = "ca-app-pub-3142193952770678/8372051443" # [There is no testing option for rewarded videos, so you can use this id for testing]

func _ready():
	show()
#	print(str(downloadserver.get_data()))
#	print(str(gamesite.get_data()))
#	print(str(mainserver.get_data()))
	if(Engine.has_singleton("AdMob")):
		if str(OS.get_name()) == 'Android':
			get_tree().connect("screen_resized", self, "onResize")
			admob = Engine.get_singleton("AdMob")
			admob.initWithContentRating(
			isReal,
			get_instance_id(),
			child_directed,
			is_personalized,
			max_ad_content_rate
			)
			$Admob.show_banner()
		return true
	return false

# Loaders

func loadBanner():
	if admob != null:
		admob.loadBanner(adBannerId, isTop)

func loadInterstitial():
	if admob != null:
		admob.loadInterstitial(adInterstitialId)
		
func loadRewardedVideo():
	if admob != null:
		admob.loadRewardedVideo(adRewardedId)

# Events

func _on_BtnBanner_toggled(pressed):
	if admob != null:
		if pressed: $Admob.show_banner()
		else: admob.hide_banner()

func _on_BtnInterstitial_pressed():
	if admob != null:
		admob.show_interstitial()
		
func _on_BtnRewardedVideo_pressed():
	if admob != null:
		admob.showRewardedVideo()

func _on_admob_network_error():
	print("Network Error")

func _on_admob_ad_loaded():
	print("Ad loaded success")
#	get_node("CanvasLayer/BtnBanner").set_disabled(false)

func _on_interstitial_not_loaded():
	print("Error: Interstitial not loaded")

func _on_interstitial_loaded():
	print("Interstitial loaded")
#	get_node("CanvasLayer/BtnInterstitial").set_disabled(false)

func _on_interstitial_close():
	print("Interstitial closed")
#	get_node("CanvasLayer/BtnInterstitial").set_disabled(true)

func _on_rewarded_video_ad_loaded():
	print("Rewarded loaded success")
#	get_node("CanvasLayer/BtnRewardedVideo").set_disabled(false)k
	
func _on_rewarded_video_ad_closed():
	print("Rewarded closed")
#	get_node("CanvasLayer/BtnRewardedVideo").set_disabled(true)
	loadRewardedVideo()
	
func _on_rewarded(currency, amount):
	print("Reward: " + currency + ", " + str(amount))
#	get_node("CanvasLayer/LblRewarded").set_text("Reward: " + currency + ", " + str(amount))

# Resize

func onResize():
	if admob != null:
		admob.resize()


