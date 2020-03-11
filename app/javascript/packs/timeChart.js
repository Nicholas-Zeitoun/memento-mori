/* Imports */
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";
import am4themes_animated from "@amcharts/amcharts4/themes/animated";

/* Chart code */
// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

let chart = am4core.create("js-time-chart", am4charts.XYChart);
chart.paddingBottom = 20;
chart.paddingTop = 40;
chart.paddingRight = 40;
chart.paddingLeft = 20;


chart.data = [{
  "date": (new Date(2020, 2, 1)),
  "value": 1
}, {
  "date": (new Date(2020, 2, 2)),
  "value": 17
}, {
  "date": (new Date(2020, 2, 7)),
  "value": 33
}, {
  "date": (new Date(2020, 2, 8)),
  "value": 42
}, {
  "date": (new Date(2020, 2, 9)),
  "value": 43
}, {
  "date": (new Date(2020, 2, 11)),
  "value": 49
}, {
  "date": (new Date(2020, 2, 12)),
  "value": 57
}, {
  "date": (new Date(2020, 2, 13)),
  "value": 64
}];

chart.colors.list = [
  am4core.color("#39095F")
];

// Create axes
let dateAxis = chart.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.labels.template.fill = am4core.color("#39095F");
dateAxis.renderer.labels.template.dy = 3;

let valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.labels.template.fill = am4core.color("#39095F");

// Create series
let series = chart.series.push(new am4charts.LineSeries());
series.dataFields.valueY = "value";
series.dataFields.dateX = "date";
series.tooltipText = "{value}"

series.tooltip.pointerOrientation = "vertical";

chart.cursor = new am4charts.XYCursor();
chart.cursor.snapToSeries = series;
chart.cursor.xAxis = dateAxis;

