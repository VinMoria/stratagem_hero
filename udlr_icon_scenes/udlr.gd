extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
    # change_color()
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass

func change_color(val):
    var tween = create_tween()
    tween.tween_property(self.material, "shader_parameter/progress", val, 0.5)
