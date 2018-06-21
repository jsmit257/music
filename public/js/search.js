var clearSearch = () => {
	$('body.searching')
		.removeClass('searching')
		.find('.search-found, .search-parent-found')
			.removeClass('search-found search-parent-found');
}

var search = (scope, what) => {

	const routes = ['artists', 'albums', 'tracks'];
	clearSearch();
	var temp2 = function(keys) { 
		keys.some((function doOver(slice) {
			var node = '^/' + routes.slice(0, slice).join('/\\d+/') + '/\\d+$';
			return (key, ndx, array) => { 
				if (slice ==4) { console.log('dammit'); return true; }
				if (!new RegExp(node).test(key)) {
					array.slice(ndx).some(doOver(++slice));
					return true;  // stop iterating
				}
				(function buildParents(depth, max) {
					var li = '#/api/v1/' + key.match(new RegExp(routes.slice(0, depth).join('/\\d+/') + '/\\d+'));
					return () => { 
						if (depth == max) {
							//console.log('edge', $(('#/api/v1' + key).replace(/\//g, '\\/')).addClass('search-found'));
							$(('#/api/v1' + key).replace(/\//g, '\\/')).addClass('search-found');
							return;
						}
						(function findRoot() {
							var result = $(('#/api/v1/' + key.match(new 
											RegExp(routes.slice(0, depth).join('/\\d+/') + '/\\d+'))).replace(/\//g, '\\/'));
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
	};
	$.ajax({
		url: '/search?scope=' + scope + '&what=' + what,
		success: (data, textStatus, jqXhr) => {
			$(document.body).addClass('searching');
			temp2(data.sort((a, b) => {  // TODO: this isn't needed anymore, is it?
				return a.length -= b.length || a.localeCompare(b) 
			}));
		},
		error: (jqXhr, textStatus, errorThrown) => {
			console.log(textStatus, errorThrown);
		}
	});

};

