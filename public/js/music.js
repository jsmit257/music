'use strict';

$((e) => {

	const routes = [ 'artists', 'albums', 'tracks' ];
	
	$(document)
		.on('click', 'li > a[href="#"]', (e, cb, openOnly) => {
			e.preventDefault();
			var $li = $(e.target.parentElement);
			if ($li.hasClass('collapsed') || !openOnly)
				$li.toggleClass('collapsed expanded');  // FIXME: expanded could be a problem
		})
		.on('click', 'li.empty > a[href="#"]', (e, cb, openOnly) => {

			// used to do this at the end but timing while searching is an issue; if there's an error we'll put
			// it back
			var $li = $(e.target.parentElement);

			if (typeof cb === 'function' && $li.prop('processing')) {
				$li.prop('processing').then(cb);
				return;
			}

			var get = e.target.dataset.get;
			var klass = get.split('/').pop();
			var next = routes[routes.indexOf(klass) + 1];

			$li.prop('processing', $.when($.ajax({
					url: get,
					accept: 'application/json',
					dataType: 'json',
					method: 'GET'
				})
					/*.catch((jqXhr, textStatus, errorThrown) => {
						console.log(textStatus, errorThrown);
					})*/)
				.then((data, textStatus, jqXhr) => {
					$('<ul>')
						.addClass(klass)
						.attr('id', get)
						.append(data.map((detail) => {
							var href = get + '/' + detail.id;
							var suffix = detail.format || '.tar';
							return $('<li>')
								.addClass('collapsed')
								.addClass('empty')
								.attr('id', href)
								.append($('<a>')
									.text(detail.name)
									.attr('href', next && '#' || (href + suffix))
									.attr(next && { 'data-get': href + '/' + next } || {}))
								.append($(next && '<a>')  // cliff notes: !tracks && download-link || nothing
									.text('download')
									.attr({
										'href': href + suffix,
										'target': '#dl-target'
									}) || void(0))  // without void(0) it tries to reference an undefined node
						}))
						.appendTo($li);  // rude, but it kinda makes sense
				})
				.then(() => {
					$li
						.removeClass('empty')
						.removeProp('processing')
				})
				.then(cb || void(0)));
		});

	// there's no nice way to do this, so...
	setTimeout((function pivotRoot($pivotRootParent) {  // yes, the parent of the root is parodixical
		return () => {
			var $realRoot = $('ul.artists', $pivotRootParent)
			if ($realRoot.length) {
				$pivotRootParent
					.append($realRoot)
					.find('ul.pivot-root')  // why doesn't remove('ul.pivot-root') do the same thing as find().remove()
					.remove()
				return
			}
			setTimeout(pivotRoot($pivotRootParent), 80);
		}
	})($('#root').click().parents('.pivot-root').parent()), 100);

});

