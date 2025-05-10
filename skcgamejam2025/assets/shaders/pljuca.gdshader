shader_type canvas_item;

uniform sampler2D texture : hint_default_white;

void fragment() {
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;
    vec4 tex_color = texture(texture, uv);
    
    tex_color.rgb = mix(tex_color.rgb, vec3(1.0, 1.0, 1.0), 0.5);  // Green gooey color
    tex_color.a = 0.8;  // Transparency for gooey effect
    
    // Output the final color
    COLOR = tex_color;
}
