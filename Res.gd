extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if Input.is_action_just_pressed("ui_accept"):  # "ui_accept" 默认对应 Enter/Return 键
        get_tree().change_scene_to_file("res://main.tscn")  # 替换为你的 main 场景路径