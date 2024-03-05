shader_type canvas_item;

uniform float lod;
uniform sampler2D SCREEN_TEXTRUE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	COLOR = texture(SCREEN_TEXTRUE, SCREEN_UV, lod);
}
