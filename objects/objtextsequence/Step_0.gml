
if keyboard_check_pressed(vk_enter)
{
	var newText = "blah";
	newText = get_string("New Text", "foo");
	//var newSequence = SetStructText(seqText, "textTrack1", newText);
	var newSequence = SetStructText(text, "textTrack1", newText);
	layer_sequence_destroy(text);
	text = layer_sequence_create("Instances", room_width/2, room_height/2, newSequence);
}