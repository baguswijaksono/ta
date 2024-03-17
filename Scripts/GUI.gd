extends CanvasLayer

onready var player = get_node("../Player")

const HEART_ROW_SIZE = 8
const HEART_OFFSIDE_SIZE = 16

#func _ready():
	#for i in player.lives:
	#	var newHeart = Sprite.new()
	#	newHeart.texture = $Heart.texture
	#	newHeart.hframes = $Heart.frame
	#	$Heart.add_child(newHeart)

func _process(delta):
	$coinText.text = String(player.coinNumber)
	
	#for Heart in $Heart.get_children():
		#var index = Heart.get_index()
		#var x =(index % HEART_ROW_SIZE) * HEART_OFFSIDE_SIZE
		#var y = (index / HEART_ROW_SIZE) * HEART_OFFSIDE_SIZE
		#Heart.position = Vector2(x,y)
		
		#var lastHeart = floor(player.lives)
		#if index > lastHeart :
		#	Heart.frame =0
		#if index == lastHeart:
		#	Heart.frame =(player.lives - lastHeart ) * 4
		#if index < lastHeart :
			#Heart.frame =4
