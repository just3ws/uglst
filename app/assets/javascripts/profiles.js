$(document).ready(function () {
  $('.datepicker').datepicker();
  $('#user_email').blur(function () {
    var email = $('#user_email').val();
    var encodedEmail = md5(email);
    var gravatar_url = 'https://secure.gravatar.com/avatar/' + encodedEmail + '?default=identicon&secure=true';
    $('#gravatar').attr('src', gravatar_url);
  });
});
