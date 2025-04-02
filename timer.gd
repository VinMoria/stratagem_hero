extends TextureProgressBar  # 或 ProgressBar


signal timeout
@export var max_time: float = 10.0  # 总时长（秒）
var current_time: float = 0.0

func _ready():
    pass

func init():
    current_time = max_time
    self.max_value = max_time
    self.value = max_time  # 初始满进度
    # 开始倒计时
    set_process(true)


func _process(delta):
    # print("Delta: ", delta)
    current_time -= delta
    self.value = current_time
    # queue_redraw()  # 强制重绘
    
    if current_time <= 0:
        set_process(false)
        print("Time's up!")
        emit_signal("timeout")

func add_time(additional_time: float):
    current_time += additional_time
    if current_time > max_time:
        current_time = max_time
    self.value = current_time
