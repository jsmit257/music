const routes = ['artists', 'albums', 'tracks'];

var clearSearch = () => {
	$('body.searching')
		.removeClass('searching')
		.find('.search-found, .search-parent-found')
			.removeClass('search-found search-parent-found');
}

var $selector = (key, depth) => { 
	return $(('#/api/v1/' + key.match(new RegExp(routes.slice(0, depth).join('/\\d+/') + '/\\d+'))).replace(/\//g, '\\/'));
};

var search = (scope, what) => {
	$.ajax({
		url: '/search?scope=' + scope + '&what=' + what,
		success: (data, textStatus, jqXhr) => {
			clearSearch();
			$(document.body).addClass('searching');
			data
				.sort((a, b) => {
					return a.length -= b.length || a.localeCompare(b) 
				})
				.some((function doOver(slice) {
					var node = '^/' + routes.slice(0, slice).join('/\\d+/') + '/\\d+$';
					return (key, ndx, array) => { 
						if (slice ==4) { console.log('dammit'); return true; }
						if (!new RegExp(node).test(key)) {
							array.slice(ndx).some(doOver(++slice));
							return true;  // stop iterating
						}
						(function buildParents(depth, max) {
							return () => { 
								if (depth == max) {
									$selector(key, depth).addClass('search-found');
									return;
								}
								(function findRoot() {
									var result = $selector(key, depth);
									if (result.length)
										return result;
									++depth;   // this is the 'global' var
									findRoot();
								})()
									.addClass('search-parent-found')
									.find('a[href="#"]') 
									.trigger('click', [buildParents(++depth, max), true]);
							};
						})(1, slice)();
					}
				})(1));
		},
		error: (jqXhr, textStatus, errorThrown) => {
			console.log(textStatus, errorThrown);
		}
	});

};

