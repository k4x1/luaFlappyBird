// chromaticAberration.glsl
//extern number aberrationAmount;

// vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
//     vec2 uv = texture_coords;
//     vec4 r = Texel(texture, uv + vec2(aberrationAmount, 0.0));
//     vec4 g = Texel(texture, uv);
//     vec4 b = Texel(texture, uv - vec2(aberrationAmount, 0.0));
//     return vec4(r.r, g.g, b.b, 1.0) * color;
// }

//chromaticAberration.glsl
extern number aberrationAmount;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 uv = texture_coords;
    vec2 offset = vec2(aberrationAmount / love_ScreenSize.x, aberrationAmount / love_ScreenSize.y);

    vec4 r = Texel(texture, clamp(uv + vec2(offset.x, -offset.y), 0.0, 1.0));
    vec4 g = Texel(texture, uv);
    vec4 b = Texel(texture, clamp(uv - vec2(offset.x, offset.y), 0.0, 1.0));

    return vec4(r.r, g.g, b.b, g.a) * color;
}