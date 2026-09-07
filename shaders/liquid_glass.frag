#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec2 u_size;
uniform sampler2D u_texture_input;

out vec4 frag_color;

vec2 sampleUv(vec2 pixel) {
  vec2 halfTexel = 0.5 / u_size;
  vec2 uv = clamp(pixel / u_size, halfTexel, vec2(1.0) - halfTexel);
#ifdef IMPELLER_TARGET_OPENGLES
  uv.y = 1.0 - uv.y;
#endif
  return uv;
}

void main() {
  vec2 pixel = FlutterFragCoord().xy;
  vec2 center = u_size * 0.5;
  float radius = max(1.0, min(u_size.x, u_size.y) * 0.5);
  float halfAxis = max(0.0, u_size.x * 0.5 - radius);

  vec2 local = pixel - center;
  vec2 axisPoint = vec2(clamp(local.x, -halfAxis, halfAxis), 0.0);
  vec2 fromAxis = local - axisPoint;
  float radialDistance = length(fromAxis);
  vec2 normal = fromAxis / max(radialDistance, 0.001);
  float depth = clamp(radius - radialDistance, 0.0, radius);

  // The input bends toward the optical center. Most of the displacement is
  // kept in the first few pixels of the rim, like a thick glass capsule.
  float rim = 1.0 - smoothstep(0.0, radius * 0.38, depth);
  float body = 1.0 - smoothstep(radius * 0.20, radius, depth);
  float displacement = rim * rim * 4.2 + body * 0.55;
  vec2 refractedPixel = pixel - normal * displacement;

  // A compact nine-tap frost keeps shapes recognizable while softening text.
  vec2 horizontal = vec2(7.0, 0.0);
  vec2 vertical = vec2(0.0, 7.0);
  vec2 diagonalA = vec2(4.5, 4.5);
  vec2 diagonalB = vec2(4.5, -4.5);
  vec4 color = texture(u_texture_input, sampleUv(refractedPixel)) * 0.20;
  color += texture(u_texture_input, sampleUv(refractedPixel + horizontal)) * 0.12;
  color += texture(u_texture_input, sampleUv(refractedPixel - horizontal)) * 0.12;
  color += texture(u_texture_input, sampleUv(refractedPixel + vertical)) * 0.12;
  color += texture(u_texture_input, sampleUv(refractedPixel - vertical)) * 0.12;
  color += texture(u_texture_input, sampleUv(refractedPixel + diagonalA)) * 0.08;
  color += texture(u_texture_input, sampleUv(refractedPixel - diagonalA)) * 0.08;
  color += texture(u_texture_input, sampleUv(refractedPixel + diagonalB)) * 0.08;
  color += texture(u_texture_input, sampleUv(refractedPixel - diagonalB)) * 0.08;

  float topLeftLight = max(0.0, dot(normal, normalize(vec2(-0.55, -0.84))));
  color.rgb += vec3(0.018 * rim * topLeftLight * color.a);
  frag_color = color;
}
