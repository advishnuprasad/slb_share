$(document).on 'ready page:load', ->
  $("a").click (e) ->
    $("#loading").show()
    return

  $("#post_tag_list").clear;

  $("#post_tag_list").selectize
    delimiter: ","
    persist: false,
    create: (input) ->
      value: input
      text: input
