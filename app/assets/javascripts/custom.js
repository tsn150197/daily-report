window.addEventListener('load', () => {
  const loader = document.getElementById('loader');
  setTimeout(() => {
    loader.classList.add('fadeOut');
  }, 300);
});

$(".pagination .first a").addClass("btn cur-p btn-primary mR-10");
$(".pagination .prev a").addClass("btn cur-p btn-info mR-10");
$(".pagination .next a").addClass("btn cur-p btn-info mR-10");
$(".pagination .last a").addClass("btn cur-p btn-primary mR-10");
$(".pagination .page a").addClass("btn cur-p btn-outline-info mR-10");
$(".pagination .current").addClass("btn cur-p btn-secondary mR-10");
$(".pagination .gap").addClass("btn cur-p mR-10");
$(".pagination").addClass("mT-30");

CKEDITOR.config.height = 800;
