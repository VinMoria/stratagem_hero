extends inputControl

@export var panel:Node2D

var stratagem_data
var memory = []

func _ready():
    # 1. 读取文件内容
    var file = FileAccess.open("res://stratagems_vault.json", FileAccess.READ)
    if file == null:
        print("Error opening file: ", FileAccess.get_open_error())
        return
    
    var json_text = file.get_as_text()
    file.close()

    # 2. 解析 JSON 字符串
    var json = JSON.new()
    var parse_result = json.parse(json_text)
    if parse_result != OK:
        print("JSON Parse Error: ", json.get_error_message(), " at line ", json.get_error_line())
        return
    
    stratagem_data = json.get_data()  # 获取解析后的字典/数组

    print("Stratagem Data: ", stratagem_data.size())


    super.start_game()


func random_icon():
    var count
    # 最近20个不重复
    while true:
        count = randi() % stratagem_data.size()
        if count not in memory:
            memory.append(count)
            if memory.size() >= 20:
                memory.remove(0)
            break
            

    return stratagem_data[count]


func gen_icon(q_dict):
    # 清除原有子元素
    for child in udlr_obj_list:
        child.queue_free()
    udlr_obj_list = []
    
    # 根据入参生成新的一题
    q_list_now = q_dict["q_list"]
    panel.set_panel(q_dict["id"], stratagem_data)
    for i in q_list_now:
        var new_icon = load("res://udlr_icon_scenes/" + i + ".tscn").instantiate()
        udlr_obj_list.append(new_icon)
        add_child(new_icon) # 添加新按钮到当前节点
    
    start_time = Time.get_ticks_msec()
