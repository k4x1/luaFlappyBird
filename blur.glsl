// blur.glsl
extern number radius;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 sum = vec4(0.0);
    int samples = 10;
    for (int i = -samples; i <= samples; i++) {
        for (int j = -samples; j <= samples; j++) {
            vec2 offset = vec2(i, j) * radius;
            sum += Texel(texture, texture_coords + offset);
        }
    }
    return sum / pow(float(samples * 2 + 1), 2.0) * color;
}
