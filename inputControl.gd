extends HBoxContainer

class_name inputControl

@export var timer: TextureProgressBar
@export var res_label: Label

var q_list_now = []
var current_index = 0
var udlr_obj_list = []
var start_time = 0
var score = 0
var run
var game_status = false
var time_reward


# Called when the node enters the scene tree for the first time.
func _ready():
    start_game()

func start_game():
    time_reward = 2
    res_label.text = "Score: 0"
    gen_icon(random_icon())
    score = 0
    timer.init()
    game_status = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass

func random_icon():
    var count = randi() % 4 + 4
    var icons = ["U", "D", "L", "R"]
    var ans = []
    for i in range(count):
        ans.append(icons[randi() % icons.size()]) # 随机返回一个图标名称
    return ans


func gen_icon(q_list):
    # 清除原有子元素
    for child in udlr_obj_list:
        child.queue_free()
    udlr_obj_list = []
    
    # 根据入参生成新的一题
    q_list_now = q_list
    for i in q_list:
        var new_icon = load("res://udlr_icon_scenes/" + i + ".tscn").instantiate()
        udlr_obj_list.append(new_icon)
        add_child(new_icon) # 添加新按钮到当前节点
    
    start_time = Time.get_ticks_msec()


func _input(event):
    # 接收输入
    if not game_status:
        if event.is_action_pressed("ui_accept"):
            start_game()
            return
    
    if game_status:
        var input_char
        if event.is_action_pressed("KEY_UP"):
            input_char = "U"
        elif event.is_action_pressed("KEY_RIGHT"):
            input_char = "R"
        elif event.is_action_pressed("KEY_DOWN"):
            input_char = "D"
        elif event.is_action_pressed("KEY_LEFT"):
            input_char = "L"
        else:
            return

        $clickSound.play()

        # 如果输入正确
        if input_char == q_list_now[current_index]:
            # print(current_index)
            # 改变颜色
            udlr_obj_list[current_index].change_color(1.0) # 假设1.0是完全黄色
            # 更新索引，准备下一个输入判断
            current_index += 1
            # 是否已经一题完成了
            if current_index >= q_list_now.size():
                # 计时
                var end_time = Time.get_ticks_msec()
                var use_time = end_time - start_time

                if use_time < 1000:
                    score += 2000
                elif use_time > 3000:
                    score += 0
                else:
                    score = score + 10 * (200 - (use_time - 1000) / 10)

                res_label.text = "Score: " + str(score)

                current_index = 0

                # 额外时间
                time_reward -= 0.1
                if time_reward < 1:
                    time_reward = 1
                timer.add_time(time_reward)

                # 生成新题
                gen_icon(random_icon())

        else:
            # 输入错误，重置当前题目
            for i in range(0, current_index):
                udlr_obj_list[i].change_color(0.0) # 假设0.0是完全白色
            current_index = 0

func game_over():
    res_label.text = "Your Final Score: " + str(score) + "\nPress Enter to Restart"
    game_status = false
