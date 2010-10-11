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
});
