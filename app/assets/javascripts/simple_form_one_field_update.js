$(document).ready(function () {
  $('input[data-one-field=true]').change(function (event) {
    event.preventDefault();

    var context = $(this);

    var form = context.parents('form');
    var root = context.data('root');
    var url  = context.data('url');

    var data = {
      'utf8':               '✓',
      '_method':            'patch',
      'authenticity_token': null,
      'action':             null,
      'controller':         null
    };

    data[root] = {};
    data.authenticity_token = form.find('input[name=authenticity_token]').val();
    data.controller = context.data('controller');
    data.action = context.data('action');
    data[root][context.data('field-name')] = context.val();

    var request = $.ajax({
      url         : url,
      data        : data,
      type        : 'PATCH',
      cache       : true,
      crossDomain : false,
      dataType    : 'json',
      context     : context
    });

    request.done(function (data, textStatus, jqXHR) {
      var current   = $(this);
      var container = $(current.parents('.form-group'));
      var field     = data[root][current.data('field-name')];

      // remove the error css class from the parent container
      container.removeClass('has-error');

      // read the value that was formatted on the server
      var formattedValue = field[current.data('field-value')]
      current.val(formattedValue);

      // clear the error messages
      current.parent().children('.help-block').remove();
    });

    request.fail(function (jqXHR, textStatus, errorThrown) {
      var current   = $(this);
      var container = $(current.parents('.form-group'));

      // tag the parent container with the error css class
      container.addClass('has-error');

      // remove the invalid value
      current.val(null);

      // clear the error messages
      current.parent().children('.help-block').remove();

      // collect the error messags
      var errorMessages = jqXHR.responseJSON.join('<br>');

      // display the error messages
      $('<span class="help-block">' + errorMessages + '</span>').insertAfter(current);
    });
  });
});


// {
//     "utf8" => "✓",
//     "_method" => "patch",
//     "authenticity_token" => "ifJnERfYkfYXav91zDHrDC6YAx+7y86lcNXeey3B77M=",
//     "user" => {
//       "email" => "aksjdfkhjasdkhj@aksjdfkhjasdkhj.com",
//       "profile_attributes" => {
//         "first_name" => "xxMike",
//         "last_name" => "Hall",
//         "bio" => "aljsdf asldkfj alskjf asdflkj asdljf lajskfdj alsjfljas lfdjlasj dflj sdflj asfljfdljaks dl",
//         "interests" => "asd, asdf, fasdf, sadjk",
//         "homepage" => "",
//         "twitter" => "",
//         "address" => "32 Bryant Court, Crystal Lake, IL",
//         "id" => "87474494-b001-4e06-bf7f-183a5ad278c8"
//       }
//     },
//     "commit" => "Save Profile",
//     "action" => "update",
//     "controller" => "profiles",
//     "id" => "aksjdfkhjasdkhj"
// }
//
// <form accept-charset="UTF-8" action="&#47;profiles&#47;aksjdfkhjasdkhj" class="simple_form edit_user" id="edit_user" method="post" novalidate="novalidate">
// <div style="display:none">
// <input name="utf8" type="hidden" value="&#x2713;" />
// <input name="_method" type="hidden" value="patch" />
// <input name="authenticity_token" type="hidden" value="ifJnERfYkfYXav91zDHrDC6YAx+7y86lcNXeey3B77M=" />
// </div>
//
// <!-- NORMAL -->
// <div class="form-group string required user_group_name">
//   <label class="string required control-label" for="user_group_name">
//     <abbr title="required">*</abbr> Name</label>
//   <div>
//     <input class="string required form-control" id="user_group_name" name="user_group[name]" type="text">
//   </div>
// </div>
//
// <!-- ERRORED -->
// <div class="form-group string required user_group_name has-error">
//   <label class="string required control-label" for="user_group_name">
//     <abbr title="required">*</abbr> Name</label>
//   <div>
//     <input class="string required form-control" id="user_group_name" name="user_group[name]" type="text" value="">
//     <span class="help-block">can't be blank</span>
//   </div>
// </div>
