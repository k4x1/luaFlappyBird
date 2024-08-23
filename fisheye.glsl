// fisheye.glsl
extern number fovTheta; // Field of View's theta

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 uv = texture_coords - 0.5;
    float r = length(uv);
    if (r > 1.5) {
        return vec4(0.0); // Outside the fisheye effect area
    }
    float theta = atan(uv.y, uv.x);
    float radius = pow(r, 1) * 1;
    vec2 new_uv = vec2(cos(theta), sin(theta)) * radius + 0.5;
    return Texel(texture, new_uv) * color;
}
