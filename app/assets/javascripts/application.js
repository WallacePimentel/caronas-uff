//= require rails-ujs
//= require jquery.min
//= require select2-full
//= require bootstrap.min
//= require cocoon

function initializeCampusSelect2() {
  $(".js-example-basic-single").each(function () {
    if ($(this).data("select2")) {
      $(this).select2("destroy");
    }
  });

  if ($(".js-example-basic-single").length === 0) {
    return;
  }

  $(".js-example-basic-single").select2({
    theme: "bootstrap",
    width: "100%",
    allowClear: true,
    placeholder: "Digite para buscar campus...",
    minimumInputLength: 0,
    minimumResultsForSearch: 0,

    ajax: {
      url: "/campus.json",
      dataType: "json",
      delay: 1000,

      data: function (params) {
        return {
          q: params.term || "",
          limit: 20,
        };
      },

      processResults: function (data) {
        return {
          results: data.results,
        };
      },

      cache: true,
    },

    language: {
      noResults: function () {
        return "Nenhum campus encontrado";
      },
      searching: function () {
        return "Procurando...";
      },
      inputTooShort: function () {
        return "Digite pelo menos 1 caractere";
      },
      errorLoading: function () {
        return "Erro ao carregar resultados";
      },
    },
  });
}

$(document).ready(function () {
  initializeCampusSelect2();

  if ($(".js-campus-search").length) {
    initializeTableSearch(".js-campus-search", filterByCampusId);
  }

  if ($(".js-carpool-campus-search").length) {
    initializeTableSearch(
      ".js-carpool-campus-search",
      filterByBeginningOrEndingCampus,
    );
  }
});

$(document).on("cocoon:after-insert", function () {
  initializeCampusSelect2();
});

function initializeTableSearch(selector, filterFunction) {
  $(selector).select2({
    theme: "bootstrap",
    width: "100%",
    placeholder: "Buscar campus...",
    minimumInputLength: 0,
    ajax: {
      url: "/campus.json",
      dataType: "json",
      delay: 1000,
      data: function (params) {
        return { q: params.term || "", limit: 20 };
      },
      processResults: function (data) {
        return { results: data.results };
      },
    },
  });

  $(selector).on("select2:select", function (e) {
    var campusId = e.params.data.id;

    $(".table tbody tr").hide().removeClass("table-warning");

    filterFunction(campusId);

    var $firstVisible = $(".table tbody tr:visible").first();
    if ($firstVisible.length) {
      $("html, body").animate(
        {
          scrollTop: $firstVisible.offset().top - 100,
        },
        500,
      );
    }
  });

  $(selector).on("select2:clear select2:unselect", function () {
    $(".table tbody tr").show().removeClass("table-warning");
  });
}

function filterByCampusId(campusId) {
  var $row = $('tr[data-campus-id="' + campusId + '"]');
  if ($row.length) {
    $row.show().addClass("table-warning");
  }
}

function filterByBeginningOrEndingCampus(campusId) {
  $(".table tbody tr").each(function () {
    var beginningId = $(this).data("beginning-campus-id");
    var endingId = $(this).data("ending-campus-id");

    if (beginningId == campusId || endingId == campusId) {
      $(this).show().addClass("table-warning");
    }
  });
}
