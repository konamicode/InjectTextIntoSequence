text = layer_sequence_create("Instances", room_width/2, room_height/2, seqText);


function SetStructText(sequence, textTrackName, newText) {

    //use an existing sequence in the scene
    var seqStruct = sequence_get(layer_sequence_get_sequence(sequence));
	//var seqStruct = sequence_get(sequence);
	var trackArray = seqStruct.tracks;
	var trackStruct;
	for (var i = 0; i < array_length(trackArray); i++)
	{
		var name = trackArray[i].name;
		if (name == textTrackName)
			trackStruct = trackArray[i];
	}
	if (!is_undefined(trackStruct))
	{
		var keyframes = variable_struct_get(trackStruct, "keyframes");
		var newKeyframe = array_create(1);
		newKeyframe[0] = sequence_keyframe_new(seqtracktype_text);
		if (!is_undefined(keyframes)) {
			var keyframeStruct = keyframes[0];
			var channels = variable_struct_get(keyframeStruct, "channels");
			
			if (!is_undefined(channels)) {
				var newStruct = array_create(1);
				newStruct[0]= sequence_keyframedata_new(seqtracktype_text);
				newStruct[0].text = newText;
				newStruct[0].wrap = variable_struct_get(channels[0], "wrap");
				newStruct[0].alignmentV = variable_struct_get(channels[0], "alignmentV");
				newStruct[0].alignmentH = variable_struct_get(channels[0], "alignmentH");
				newStruct[0].fontIndex = variable_struct_get(channels[0], "fontIndex");
				newStruct[0].channel = variable_struct_get(channels[0], "channel");
				

			}
			newKeyframe[0].length = keyframeStruct.length;
			newKeyframe[0].channels = newStruct;
		}
		
	}
	var newSeqStruct = sequence_track_new(seqtracktype_text);
	newSeqStruct.name = variable_struct_get(trackStruct, "name");
	newSeqStruct.keyframes = newKeyframe;
	//newSeqStruct.tracks = seqStruct.tracks; //maybe copy over the track scale/position to preserve formatting?
	trackArray[0] = newSeqStruct;
	seqStruct.tracks = trackArray;
	
	return seqStruct;

}