shader_type canvas_item;

// 定义一个可调节的参数（范围 0~1，0=白色，1=黄色）
uniform float progress: hint_range(0, 1) = 0.0;
uniform vec4 target_color: source_color = vec4(1.0, 1.0, 0.0, 1.0); // 目标颜色（黄色）

void fragment() {
    // 获取原始像素颜色
    vec4 original_color = texture(TEXTURE, UV);
    
    // 计算混合颜色（白色 -> 黄色）
    vec4 white = vec4(1.0, 1.0, 1.0, original_color.a); // 白色（保持透明度）
    vec4 final_color = mix(white, target_color, progress);
    
    // 应用混合颜色（同时保留原始亮度/透明度）
    COLOR = original_color * final_color;
}
