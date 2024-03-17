extends Area2D



func _on_Coin_body_entered(body):
	if body.has_method("coinPickup"):
		body.coinPickup()
		#$nama_node.play("Nama Animasi") animasi panggil sini
		yield(get_tree().create_timer(0.7),"timeout") #delay misal mau ada pickup animation
		queue_free()
