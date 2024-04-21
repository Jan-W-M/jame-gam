extends Area3D

@onready var player = get_parent().get_node("Player")
var orangeportalpos = get_parent().get_node("player").position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	player.position = orangeportalpos
