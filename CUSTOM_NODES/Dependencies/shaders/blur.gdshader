shader_type canvas_item;

uniform float amount: hint_range(0.0, 8.0);
uniform vec3 col: source_color = vec3(1,1,1);

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	COLOR.rgb = col * textureLod(SCREEN_TEXTURE, SCREEN_UV, amount).rgb;
}
