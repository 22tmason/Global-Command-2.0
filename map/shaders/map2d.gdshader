shader_type canvas_item;

uniform sampler2D terrain_image : source_color, filter_linear_mipmap, repeat_enable;

void fragment() {
    vec4 terrain_texture = texture(terrain_image, UV);
    COLOR = terrain_texture;
}
