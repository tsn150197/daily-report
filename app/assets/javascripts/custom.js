window.addEventListener("load", () => {
  const loader = document.getElementById("loader");
  setTimeout(() => {
    loader.classList.add("fadeOut");
  }, 300);
  var mydiv = $(".commet-report");
  mydiv.scrollTop(mydiv.prop("scrollHeight"));
  $(".image-report img").addClass("size-img-report");
});

CKEDITOR.config.height = 800;
