extends Node2D

func _ready():
    pass

func set_panel(id, data):
    $icon.texture = load("res://stratagem_icons/" + str(id) + ".webp") # 设置图标纹理
    $des_zh.text = data[id - 1].des_zh # 设置中文描述
    $des_en.text = data[id - 1].des_en # 设置英文描述
