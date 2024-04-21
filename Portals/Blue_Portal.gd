extends Area3D

@onready var player = get_parent().get_node("Player")
@onready var orangeportalpos = get_parent().get_node("Orange_Portal").position
#var orangeportalpos = get_parent().get_node("Player").position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if $"../Player".teleportable == true:
		player.position = orangeportalpos
		$"../Player".teleportable = false
		$Blue_Portal_Entered.start()


func _on_orange_portal_entered_timeout():
	$"../Player".teleportable = true
	print("teleportable")
