$(document).ready(function () {
  $('.article_like').on("ajax:success", function (event, data, status, xhr) {
    console.log(data);
  });
});