shader_type canvas_item;

uniform vec4 tint_color = vec4(0.8, 0.1, 0.0, 1.0);

void fragment() {
    COLOR = texture(TEXTURE, UV) * tint_color;
}