$((e) => {
	e.preventDefault();
	const routes = ['artists', 'albums', 'tracks'];
	var $target = $(e.target);
	var $owner = $target.parents('ul'[0];
	var promptParents t= [!($owner.children.length - 1)];
	if (promptParents[0] && $owner.name === 'albums') { 
		promptParents.push(!$owner.parents('ul')[0].children.length - 1);
	}

});

