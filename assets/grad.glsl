extern number time;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 uv = texture_coords;
    
    vec2 centered = uv - 0.5;
    
    float angle = atan(centered.y, centered.x) + time;
    
    float normalizedAngle = (angle + 3.14159265359) / (2.0 * 3.14159265359);
    
    vec3 rainbow;
    rainbow.r = sin(normalizedAngle * 6.28318530718 + 0.0) * 0.5 + 0.5;
    rainbow.g = sin(normalizedAngle * 6.28318530718 + 2.09439510239) * 0.5 + 0.5;
    rainbow.b = sin(normalizedAngle * 6.28318530718 + 4.18879020478) * 0.5 + 0.5;
    
    return vec4(rainbow, 1.0) * color;
}
