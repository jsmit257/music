'use strict';

$((e) => {

	const routes = [ 'artists', 'albums', 'tracks' ];
	
	var createList = ($li, get, klass, next) => { 
		var createDetail = (details) => {
			return Object
				.getOwnPropertyNames(details)
				.sort((a, b) => { 
					return details[a].name.localeCompare(details[b].name);
				})
				.map((key, ndx, arr) => {
					var detail = details[key];
					var href = get + '/' + detail.id;
					var $existing = $(('#' + href).replace(/\//g, '\\/'));
					if ($existing.length) {
						if ($existing.hasClass('collapsed') && detail.search_parent_found)
							$existing.toggleClass('collapsed expanded touched-by-search')
						return createList(
								$existing
									.addClass(detail.search_parent_found && 'search-parent-found')
									.addClass(detail.search_found && 'search-found'), 
								href + '/' + next, 
								next, 
								routes[routes.indexOf(next) + 1]
							) // returns a function
							(detail.children || {});
					}
					var suffix = detail.format || '.tar';
					var $result;
					return ($result = $('<li>'))
						.addClass(detail.search_parent_found && 'expanded search-parent-found' || 'collapsed')
						.addClass(detail.search_found && 'search-found')
						.addClass(!detail.children && 'empty' || 'touched-by-search')
						.attr('id', href)
						.append($('<a>')
							.text(detail.name)
							.attr('href', next && '#' || (href + suffix))
							.attr(next && { 'data-get': href + '/' + next } || {})  // maybe use dataset
							.addClass('label'))
						.append($(next && '<a>')  // cliff notes: !tracks && download-link || nothing
							.text('download')
							.attr({
								'href': href + suffix,
								'target': '#dl-target'
							}) || void(0))  // without void(0) it tries to reference an undefined node
						.append(createList($result, href + '/' + next, next, routes[routes.indexOf(next) + 1])(detail.children || {}));
				});
		};
		return (data, textStatus, jqXhr) => {
			$('<ul>')
				.addClass(klass)
				.attr('id', get)
				.append(createDetail(data))
				.appendTo($li);
		};
	};

	$(document)
	.on('child-data', 'li > a[href="#"]', (e, $li, get, klass, next, details) => {  // public API
		createList($li, get, klass, next)(details);
	})
	.on('click', 'li > a[href="#"]', (e, cb, openOnly) => {
		e.preventDefault();
		var $li = $(e.target.parentElement);
		if ($li.hasClass('collapsed') || !openOnly)
			$li.toggleClass('collapsed expanded');  // FIXME: expanded could be a problem
		if ($li.hasClass('collapsed touched-by-search'))
			$li.removeClass('touched-by-search')
	})
	.on('click', 'li.empty > a[href="#"]', (e, cb, openOnly) => {
		var $li = $(e.target.parentElement);
		var get = e.target.dataset.get;
		var klass = get.split('/').pop();
		var next = routes[routes.indexOf(klass) + 1];
		($li.prop('processing') && $li || $li.prop('processing', $.ajax({
				url: get,
				accept: 'application/json',
				dataType: 'json',
				method: 'GET'
			})
			.fail((jqXhr, textStatus, errorThrown) => {
				console.log(textStatus, errorThrown);
			})
			.done(() => { $li.removeClass('empty').removeProp('processing') })
			.then(createList($li, get, klass, next)))
		 )  // returns a $li with guaranteed processing prop
			.prop('processing')
			.then(cb || void(0));
	})
	.find('#root')
		.trigger('click', () => { 
			$('.pivot-root')
				.parent()
				.append($('ul.artists'))
				// not sure why the find is important, but pivotRoot.parent().append().remove(pivotRoot)
				// throws an error
				.find('.pivot-root')
				.remove(); 
		});
});

