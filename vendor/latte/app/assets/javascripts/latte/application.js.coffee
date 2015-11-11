#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require file-field
#= require jquery_nested_form
#= require ckeditor/init
#= require bootstrap-tagsinput
#= require bootstrap-typeahead
#= require_tree .

$(document).ready ->

  $("#nested-control input").on "click", ->
    $("form fieldset").hide()
    $("form ##{$(this).val()}").show()

  $("form fieldset").each ->
    if $(this).find(".has-error").length > 0
      control = $("#nested-control label[for=show_#{$(this).attr("id")}]:first")
      control.addClass("text-danger")
      control.append(
        $("<span />", { class: "glyphicon glyphicon-warning-sign" })
      )

  $("#nested-control input:first").trigger "click"
  $("#nested-control .text-danger:first input").trigger "click"

  ##
  # Add bootstrap columns classes to .fields
  # nested form class
  $(".fields").addClass("col-xs-12 col-lg-6")

  ##
  # Add bootstrap-tagsinput functionallity
  # to data-role='tags' elements
  $("[data-role='tags']").tagsinput(
    tagClass: 'badge',
    typeahead: {
      displayText: (item) -> item
      source: $.get("/latte/tags.json")
    }
  )

  ##
  # Add image preview functionallity
  # view vendor/assets/javascript/file-field.js
  # view config/initializers/latte_form_builer.rb
  $(".image-preview").each ->
    imagePreviewer($(this))

  ##
  # view vendor/assets/javascript/image_file_field.js
  # view config/initializers/latte_form_builer.rb
  $(".datafile-preview").each ->
    datafilePreviewer($(this))

##
# Nested form callback
$(document).on "nested:fieldAdded", (event) ->
  field = event.field
  container = field.closest(".fields")
  container.addClass("col-xs-12 col-lg-6")
  imagePreviewer(field.find(".image-preview"))
  datafilePreviewer(field.find(".datafile-preview"))

  if container.find("[role=tab]").length > 0
    counter = $(".fields:visible").length
    container.find("[role=tab]").each ->
      target = $(this).attr("aria-controls")
      $(this).attr("href", "##{target}#{counter}")
      $(this).attr("aria-controls", "#{target}#{counter}")
      $("##{target}").attr("id", "#{target}#{counter}")
