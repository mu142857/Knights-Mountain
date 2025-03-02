shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture;
uniform vec4 water_colour: source_color;
uniform sampler2D wave_noise: repeat_enable;

void fragment() {
	vec2 water_wave = (texture(wave_noise, UV + TIME * 0.02).rg - 0.5) * 0.02;
	vec2 uv = vec2(SCREEN_UV.x, SCREEN_UV.y - UV.y) + water_wave;
	vec4 colour = texture(screen_texture, uv);
	float mixed_value = 1.0 - UV.y;

	float average_colour = (colour.r + colour.g + colour.b) / 3.0;
	average_colour = pow(average_colour, 1.4);
	mixed_value += average_colour;

	mixed_value = clamp(mixed_value, 0.0, 0.7);
	COLOR = mix(water_colour, colour, mixed_value);
}