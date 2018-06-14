'use strict';
$((e) => {

	const routes = [ 'artists', 'albums', 'tracks' ];
	
	var target = document.getElementById('root');

	$(document)
		.on('click', 'li > a[href="#"]', (e) => {
		
			e.preventDefault();

			$(e.target.parentElement).toggleClass('collapsed');

		})
		.on('click', 'li.empty > a[href="#"]', (e) =>{

			var $li = $(e.target.parentElement);  // little duplication only on the first pass

			var get = e.target.dataset.get;
			var klass = get.split('/').pop();
			var next = routes[routes.indexOf(klass) + 1];

			$.ajax({
				url: get,
				accept: 'application/json',
//				context: args.root,
				dataType: 'json',
				method: 'GET',
				error: (jqXhr, textStatus, errorThrown) => {
					console.error(textStatus, errorThrown);
				},
				success: (data, textStatus, jqXhr) => {
					$('<ul>')
						.addClass(klass)
						.attr('data-get', get)
						.append(data.map((detail) => {
							var href = get + '/' + detail.id;
							var suffix = '.tar';
							return $('<li>')
								.addClass('collapsed')
								.addClass('empty')
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
						.appendTo($li.removeClass('empty'));  // rude, but it kinda makes sense
				},
			});

		});

	$(target)
		.click()  // are we sure this is synchronous?
		.parents('.pivot-root')
		.parent()
		.append($('.pivot-root > li > ul'))
		.remove('.pivot-root');

});

