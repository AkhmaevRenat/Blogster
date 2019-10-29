$(document).on('turbolinks:load', function () {
  $('#followers_button').click(function () {
    document.getElementById('followers').style.display = 'block';
    document.getElementById('articles').style.display = 'none';
    document.getElementById('follows').style.display = 'none';
  });
  $('#follows_button').click(function () {
    document.getElementById('followers').style.display = 'none';
    document.getElementById('articles').style.display = 'none';
    document.getElementById('follows').style.display = 'block';
  });
  $('#articles_button').click(function () {
    document.getElementById('followers').style.display = 'none';
    document.getElementById('articles').style.display = 'block';
    document.getElementById('follows').style.display = 'none';
  });
});