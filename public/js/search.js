/*
 * © 2018 dsmith
 */
'use strict';

$((e) => { 
	const routes = [ 'artists', 'albums', 'tracks' ];
	const scope = document.body.dataset.searchScope;
	$(document)
	.on('reset', 'form[name="search"]', (e) => {
		$('body.searching')
			.removeClass('searching');
		$('.search-found, .search-parent-found')
			.removeClass('search-found search-parent-found');
		$('.expanded.touched-by-search')
			.toggleClass('expanded collapsed touched-by-search');
	})
	.on('submit', 'form[name="search"]', (e) => {
		e.preventDefault();
		$.ajax({
			url: '/search?scope=' + scope + '&what=' + $('input[name="what"]', e.target).val(),
			success: (data, textStatus, jqXhr) => {
				$(e.target).trigger('resest')
				$(document.body).addClass('searching');
				// if i still had a pivot-root, i could just pass all this stuff to it
				Object
					.getOwnPropertyNames(data)
					.forEach((key, ndx, arr) => {
						var $li;
						var klass = 'albums';  // depends on root having children
						var next = routes[routes.indexOf(klass) + 1];
						($li = $('#' + key.replace(/\//g, '\\/')))
							.addClass('search-parent-found')
							.addClass(data[key].search_found && 'search-found')
							.addClass('expanded touched-by-search')
							.removeClass('collapsed empty')
							.find('a[href="#"]')
								.trigger('child-data', [$li, key + '/' + klass, klass, next, data[key].children || {}]);
					});
			},
			error: (jqXhr, textStatus, errorThrown) => {
				console.log(textStatus, errorThrown);
			}
		});
	});
})
