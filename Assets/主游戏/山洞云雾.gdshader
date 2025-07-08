shader_type canvas_item;

//noise texture
uniform sampler2D noise_texture: repeat_enable, filter_nearest;
uniform float density: hint_range(0.0, 1.0) = 0.30;
uniform vec2 speed = vec2(-0.1, 0.1);

void fragment() {
    vec2 uv = UV + speed * TIME;
    float noise = texture(noise_texture, uv).r;
    float fog = clamp(noise * 2.25 - 1.0, 0.0, 1.0);

    // 计算垂直梯度：UV.y 越大（越靠上）因子越小
	float t = pow(UV.y, 8.0);
    float vertical_gradient = clamp(t, 0.0, 1.0);

    COLOR.a *= fog * density * vertical_gradient;
}
