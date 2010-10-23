// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
	$("#adjust_reports_filter input").addClass('form_field').hide().each(function() {
		switch ($(this).attr('type')) {
			case "submit":
				$(this).before("<sup><a id=\"adjust_reports_filter_link\" class=\"static_field\" href=\"#\">"+$(this).attr("value")+"</a></sup>");
				$(this).after(" <a id=\"adjust_reports_filter_cancel\" class=\"form_field\" href=\"#\" style=\"display:none;\">Cancel</a>");
				break;
			case "hidden":
				break;
			default:
				$(this).before("<span class=\"static_field\" href=\"#\">"+$(this).attr("value")+"</span>");
		}
	});
	$("#adjust_reports_filter_link").click(function() {
		$("table.reports").hide();
		$("#adjust_reports_filter .static_field").hide();
		$("#adjust_reports_filter .form_field").show();
		return false;
	});
	$("#adjust_reports_filter_cancel").click(function() {
		$("#adjust_reports_filter .form_field").hide();
		$("#adjust_reports_filter .static_field").show();
		$("table.reports").show();
		return false;
	});

	$("a[data-method=delete]").click(function() {
		if (confirm($(this).attr('data-confirm')) == true) {
			handleMethod($(this));
		}
		return false;
	});
});

function handleMethod(element) {
	var method = element.attr('data-method');
	var url = element.attr('href');
	var csrf_param = $('meta[name=csrf-param]');
	var csrf_token = $('meta[name=csrf-token]');

	element.before('<form method="post" action="'+url+'" style="display:none;"></form>');
	var form = element.prev('form');

	if (method !== 'post') {
		form.prepend('<input type="hidden" name="_method" value="'+method+'" />');
	}

	if (csrf_param) {
		var param = csrf_param.attr('content');
		var token = csrf_token.attr('content');
		form.prepend('<input type="hidden" name="'+param+'" value="'+token+'" />');
	}

	form.submit();
}
