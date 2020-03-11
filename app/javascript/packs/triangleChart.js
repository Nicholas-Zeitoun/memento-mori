// Import stuff
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";

// Retrieve user's dank scores
const chartDiv = document.getElementById("js-triangle-chart");
const scoreCreation = Number.parseInt(chartDiv.dataset["creation"], 10);
const scoreCollection = Number.parseInt(chartDiv.dataset["collection"], 10);
const scoreEngagement = Number.parseInt(chartDiv.dataset["engagement"], 10);

// Create chart instance
let chart = am4core.create("js-triangle-chart", am4charts.PieChart);
chart.innerRadius = am4core.percent(40);
chart.paddingBottom = 20;

// Create pie series
let series = chart.series.push(new am4charts.PieSeries());
series.dataFields.value = "points";
series.dataFields.category = "score";
series.slices.template.propertyFields.fill = "color";
series.labels.template.disabled = true;

// Add data
chart.data = [{
  "score": "Creation",
  "points": scoreCreation,
  "color": am4core.color("#87629A")
},{
  "score": "Collection",
  "points": scoreCollection,
  "color": am4core.color("#60367d")
},{
  "score": "Engagement",
  "points": scoreEngagement,
  "color": am4core.color("#39095F")
}];

// Add a legend
chart.legend = new am4charts.Legend();
chart.legend.labels.template.fill = am4core.color("#39095F");
