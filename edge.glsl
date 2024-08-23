// edge.glsl
extern vec2 texSize;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 texel = vec2(1.0 / texSize.x, 1.0 / texSize.y);
    vec4 tc = Texel(texture, texture_coords);
    vec4 sum = vec4(0.0);
    sum += Texel(texture, texture_coords + texel * vec2(-1, -1)) * -1.0;
    sum += Texel(texture, texture_coords + texel * vec2( 0, -1)) * -1.0;
    sum += Texel(texture, texture_coords + texel * vec2( 1, -1)) * -1.0;
    sum += Texel(texture, texture_coords + texel * vec2(-1,  0)) * -1.0;
    sum += Texel(texture, texture_coords + texel * vec2( 1,  0)) * -1.0;
    sum += Texel(texture, texture_coords + texel * vec2(-1,  1)) * -1.0;
    sum += Texel(texture, texture_coords + texel * vec2( 0,  1)) * -1.0;
    sum += Texel(texture, texture_coords + texel * vec2( 1,  1)) * -1.0;
    sum += tc * 8.0;
    return vec4(vec3(length(sum.rgb)), tc.a) * color;
}
