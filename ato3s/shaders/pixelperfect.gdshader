shader_type spatial;
render_mode skip_vertex_transform;

void vertex() {
    // Assumes camera is always at rotation.x = -30 and rotation.z is 0
    vec4 world_vertex = MODEL_MATRIX * vec4(VERTEX, 1.0);
    float up = world_vertex.y;
    world_vertex.y = 0.0;
    vec4 view_vertex = VIEW_MATRIX * world_vertex;
    view_vertex.y += up;
    VERTEX = view_vertex.xyz;
}
