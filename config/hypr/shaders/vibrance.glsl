#version 300 es
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 color = texture(tex, v_texcoord);

    // Tune this — 0.0 (no effect) to 1.0+ (very vivid)
    float Vibrance = 0.5;

    float luma = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
    float maxC = max(color.r, max(color.g, color.b));
    float minC = min(color.r, min(color.g, color.b));
    float sat  = maxC - minC;

    color.rgb = mix(vec3(luma), color.rgb, 1.0 + Vibrance * (1.0 - sat));

    fragColor = vec4(color.rgb, color.a);
}
