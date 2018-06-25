'use strict';

$((e) => {

	const routes = [ 'artists', 'albums', 'tracks' ];
	
	var createList = ($li, get, klass, next) => { 
		var createDetail = (detail) => {
			var href = get + '/' + detail.id;
			var suffix = detail.format || '.tar';
			return $('<li>')
				.addClass('collapsed')
				.addClass('empty')
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
		};
		return (data, textStatus, jqXhr) => {
			$('<ul>')
				.addClass(klass)
				.attr('id', get)
				.append(data.map(createDetail))
				.appendTo($li);  // rude, but it kinda makes sense
		};
	};

	$(document)
		.on('click', 'li > a[href="#"]', (e, cb, openOnly) => {
			e.preventDefault();
			var $li = $(e.target.parentElement);
			if ($li.hasClass('collapsed') || !openOnly)
				$li.toggleClass('collapsed expanded');  // FIXME: expanded could be a problem
		})
		.on('click', 'li.empty > a[href="#"]', (e, cb, openOnly) => {
			var $li = $(e.target.parentElement);
			var get = e.target.dataset.get;
			var klass = get.split('/').pop();
			var next = routes[routes.indexOf(klass) + 1];
			($li.prop('processing') && $li || $li.prop('processing', $.when($.ajax({
					url: get,
					accept: 'application/json',
					dataType: 'json',
					method: 'GET'
				}))
				.fail((jqXhr, textStatus, errorThrown) => {
					console.log(textStatus, errorThrown);
				})
				.then(createList($li, get, klass, next) )
				.done(() => { $li.removeClass('empty').removeProp('processing') }))
			 )  // returns a $li with guaranteed processing prop
				.prop('processing')
				.then(cb || void(0));
		});

	$('#root').trigger('click', () => { 
		$('.pivot-root')
			.parent()
			.append($('ul.artists'))
			// not sure why the find is important, but pivotRoot.parent().append().remove(pivotRoot)
			// throws an error
			.find('.pivot-root')
			.remove(); 
	});

});

