# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  if $('body.photos.new').length or $('body.photos.create').length
    $fileupload = $('#fileupload')
    $input = $($fileupload.data('input-selector'))
    $fileupload_container = $('#fileupload-container')
    $fileupload_form_container = $('#fileupload-form-container')
    $fileupload_result = $('#fileupload-result')
    $uploads = $('#uploads')
    $creator_field = $('#creator')
    photos_url = $fileupload_container.data('photos-url')

    $fileupload.fileupload
      add: (e, data) ->
        $fileupload_result.find('.status').remove() # remove previous upload message
        types = /(\.|\/)(jpg|png|jpeg)$/i
        file = data.files[0]
        if types.test(file.type) || types.test(file.name)
          $input.val('')
          data.context = $(tmpl("template-uploading", file))
          $uploads.append(data.context)
          data.submit()
        else
          alert("#{file.name} is not an image file")

      progress: (e, data) ->
        if data.context
          progress = parseInt(data.loaded / data.total * 100, 10)
          data.context.find('.progress-bar').css('width', progress + '%')

      done: (e, data) ->
        file = data.files[0]
        console.log(data)
        s3_key = $('input[name=key]', $fileupload).val().replace('${filename}', file.name)
        # $input.val(s3_key)

        context = data.context

        $.ajax(
          url: photos_url,
          dataType: 'json',
          method: 'POST',
          data: {
            photo: {
              creator: $creator_field.val(),
              s3_key: s3_key
            }
          },
          success: (data, text_status, jqXHR) ->
            data.name = file.name
            context.html($(tmpl("template-uploaded", data)))
        )

      fail: (e, data) ->
        alert("#{data.files[0].name} failed to upload.")

$(document).ready(ready)
$(document).on("page:load load", ready)
