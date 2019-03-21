const selectable = new Selectable({
  appendTo: "#list-reports",
  filter: ".report-infor",
  classes: {
    lasso: "report-lasso",
    selected: "report-selected",
    container: "report-container",
    selecting: "report-selecting",
    selectable: "report-infor",
    unselecting: "report-unselecting"
  },
  lasso: {
    border: "2px dashed rgba(10, 219, 45, 0.5)",
    borderRadius: "10px",
    backgroundColor: "rgba(10, 219, 45, 0.05)"
  }
});

selectable.on("start", function () {
  $(".report-infor").removeClass("select-report");
  $(".flash-report").html("");
});

selectable.on("end", function () {
  list_report = new Array();
  $("#delete-selection").html("");
  if (selectable.getSelectedNodes() != "") {
    selectable.getSelectedNodes().forEach(element => {
      list_report.push(element.id);
    });
    $("#delete-selection").html("<a href='" +
      Routes.trainee_bulk_report_path(list_report) +
      "' data-method='delete' class='btn btn-danger' data-confirm='" +
      I18n.t("js.reports.confirm_delete_select") + "'>" +
      I18n.t("js.reports.delete_selected") + "</a>");
  }
});
