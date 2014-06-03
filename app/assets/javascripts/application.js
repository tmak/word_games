// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
//= require_self

function answerParamName(fieldId) {
  return "solution[answers][" + fieldId + "]";
}

function showNotice(notice) {
  var noticeSelector = $("#notice");
  noticeSelector.html(notice).show();
  setTimeout(function() { noticeSelector.fadeOut() }, 2000);
}

function removeErrorMessages() {
  $(".help-block").remove();
  $(".form-group").removeClass("has-error");
}

function newMadLibCreated(event, data, status, xhr) {
  removeErrorMessages();

  $("#new_mad_lib input[type=submit]").attr("value", "Fill In");
  $("#mad_lib_text").before("<p class='form-control-static'>" + data["text"] + "</p>").remove();

  var fieldsHtml = [];

  for(var field in data["fields"])
  {
    field = data["fields"][field];
    fieldsHtml.push("<div class='form-group form-group-field'>" +
      "<label for='" + answerParamName(field["id"]) + "' class='col-sm-2 control-label'>" + field["label"] + ":</label>" +
      "<div class='col-sm-10'><input type='text' name='" + answerParamName(field["id"]) + "' id='" + answerParamName(field["id"]) + "' class='form-control' value=''></div>" +
      "</div>");
  }

  $("#new_mad_lib .form-group:last").before(fieldsHtml.join(""));
  $("#new_mad_lib").append("<input type='hidden' name='solution[mad_lib_id]' value='" + data["id"] + "'>");

  showNotice("New Mad Lib created");

  $("#new_mad_lib")
    .attr("action", "/solutions")
    .unbind()
    .on("ajax:success", newSolutionCreated);
}

function creatingNewMadLibFailed(event, xhr, status, error) {
  var errors = $.parseJSON(xhr.responseText);

  if (errors["text"]) {
    $("#mad_lib_text").next(".help-block").remove();
    $("#mad_lib_text").after("<span class='help-block'>" + errors["text"][0] + "</span>").parents(".form-group").addClass("has-error");
  }
}

function newSolutionCreated(event, data, status, xhr) {
  removeErrorMessages();

  var answersHtml = [];

  for(var answer in data["answers"]) {
    answer = data["answers"][answer];

    answerParamName(answer["id"]);
    answersHtml.push("<div class='form-group form-group-field'>" +
      "<label class='col-sm-2 control-label'>" + answer["field_label"] + ":</label>" +
      "<div class='col-sm-10'><p class='form-control-static'>" + answer["text"] + "</p></div>" +
      "</div>");
  }

  $("#new_mad_lib .form-group-field").remove();
  $("#new_mad_lib .form-group:last").before(answersHtml.join(""));
  $("#new_mad_lib .form-group:last").before("<div class='form-group'>" +
          "<label class='col-sm-2 control-label'>Result:</label>" +
          "<div class='col-sm-10'><p class='form-control-static'>" + data["result"] + "</p></div>" +
          "</div>");
  $("#new_mad_lib input[type=hidden]").remove();
  $("#new_mad_lib input[type=submit]").before("<a id='start_again' class='btn btn-default' href='#'>Start again</a>").remove();

  showNotice("Your solution has been created");

  $("#new_mad_lib").unbind();
  $("#start_again").one("click", startAgain);
}

function startAgain() {
  $("#new_mad_lib .form-group:last").prevAll(".form-group").remove();
  $("#start_again").before("<input type='submit' class='btn btn-default' value='Create'>").remove();
  $("#new_mad_lib .form-group:last").before("<div class='form-group'>" +
    "<label class='col-sm-2 control-label' for='mad_lib_text'>Template:</label>" +
    "<div class='col-sm-10'><textarea class='form-control' cols='40' id='mad_lib_text' name='mad_lib[text]' rows='10'></textarea></div>" +
    "</div>");
  $("#new_mad_lib")
    .attr("action", "/mad_libs")
    .unbind()
    .on("ajax:success", newMadLibCreated).on("ajax:error", creatingNewMadLibFailed);
}

$(function() {
  var newMadLibForm = $("#new_mad_lib");

  if (newMadLibForm.length) {
    $(".container").prepend("<div id='notice_container'><p id='notice' class='alert alert-success'></p></div>");
    newMadLibForm.on("ajax:success", newMadLibCreated).on("ajax:error", creatingNewMadLibFailed);
  }
});

