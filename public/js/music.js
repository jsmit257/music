/*
 * � 2018 dsmith
 */
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
					var suffix = detail.format || '.tar';
					var $result = $(('#' + href).replace(/\//g, '\\/'));
					if (!$result.length) {
						$result = $('<li>')
							.addClass('collapsed')
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
								}) || void(0));  // without void(0) it tries to reference an undefined node
					}
					$result
						.addClass(detail.search_parent_found && 'search-parent-found')
						.addClass(detail.search_found && 'search-found')
						.addClass(detail.children || 'empty')
						.append(createList($result, href + '/' + next, next, routes[routes.indexOf(next) + 1])(detail.children || {}));
					if ($result.hasClass('collapsed search-parent-found'))
						$result.toggleClass('collapsed expanded touched-by-search')
					return $result;
				});
		};
		return (data, textStatus, jqXhr) => {
			var $ul = $('ul.' + klass, $li);
			if (!$ul.length) {
				$ul = $('<ul>')
					.addClass(klass)
					.attr('id', get)
					.appendTo($li);
			}
			$ul.append(createDetail(data));
		};
	};

	$(document)
	.on('child-data', 'li > a[href="#"]', (e, $li, get, klass, next, details) => {  // public API
		createList($li, get, klass, next)(details);
	})
	.on('click', 'li > a[href="#"]', (e, cb, openOnly) => {
		e.preventDefault();
		$(e.target.parentElement)
			.toggleClass('collapsed expanded');  // FIXME: expanded could be a problem
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
			$('ul.artists')
				.insertBefore($('.pivot-root'));
			$('.pivot-root')
				.remove();
		});
});
