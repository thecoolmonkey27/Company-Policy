shader_type canvas_item;

void fragment() {
    COLOR = vec4(UV.x, UV.y, 0.5, 0.3);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
