shader_type canvas_item;

uniform sampler2D palette_texture;
uniform float palette_size = 8.0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Check if the pixel is transparent
    if (tex_color.a < 0.1) {
        // Keep transparent pixels unchanged
        COLOR = tex_color;
    } else {
        // Calculate the index for the palette
        float index = tex_color.r * (palette_size - 1.0);
        vec2 palette_uv = vec2(index / (palette_size - 1.0), 0.0);
        vec4 palette_color = texture(palette_texture, palette_uv);

        // Preserve the original alpha
        palette_color.a = tex_color.a;

        COLOR = palette_color;
    }
}