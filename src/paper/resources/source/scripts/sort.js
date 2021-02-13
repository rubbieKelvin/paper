function sort_types (list) {
	const image = [];
	const audio = [];
	const text  = [];
	const checklist  = []; 

	// separate
	list.forEach(element => {
		if (element.type === "image") image.push(element);
		else if (element.type === "audio") audio.push(element);
		else if (element.type === "text") text.push(element);
		else if (element.type === "list") checklist.push(element);
	});

	// algorithim for grouping images
	// there should be at least one image in a row
	// and two images max in a row
	if (image.length % 2 === 0) {
		image.forEach(
			element => {
				element.widthRatio = .5;
			}
		)
	}else{
		image.slice(0, image.length-1).forEach(
			element => {
				element.widthRatio = .5;
			}
		)

		image[image.length-1].widthRatio = 1.0;
	}

	return [...image, ...audio, ...text, ...checklist];
}