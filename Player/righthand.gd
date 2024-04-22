extends Area3D

var item_to_spawn
var item_to_drop : Item

@onready var hand = $Hand
@onready var root_scene = $"../.."

var item_1_hr = preload("res://items/item_1_hr.tscn")
var item_1 =preload("res://items/item_1.tscn")
var item_2_hr = preload("res://items/item_2_hr.tscn")
var item_2 = preload("res://items/item_2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elaqpsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(body):

	if body.get_name() == "Item1":
		if hand.get_child(0) != null: 
			hand.get_child(0).queue_free()
			root_scene.get_parent().add_child(item_to_drop)
			item_to_drop.dropped = true
		body.queue_free()
		item_to_drop = item_1.instantiate()
		item_to_spawn = item_1_hr.instantiate()
		hand.add_child(item_to_spawn)
	if body.get_name() == "Item2":
		if hand.get_child(0) != null: 
			hand.get_child(0).queue_free()
			root_scene.get_parent().add_child(item_to_drop)
			item_to_drop.dropped = true
		body.queue_free()
		item_to_drop = item_2.instantiate()
		item_to_spawn = item_2_hr.instantiate()
		hand.add_child(item_to_spawn)
