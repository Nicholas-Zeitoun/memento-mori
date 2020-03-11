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
chart.innerRadius = am4core.percent(60);

// Create pie series
let series = chart.series.push(new am4charts.PieSeries());
series.dataFields.value = "points";
series.dataFields.category = "score";

// Add data
chart.data = [{
  "score": "Creation",
  "points": scoreCreation,
},{
  "score": "Collection",
  "points": scoreCollection
},{
  "score": "Engagement",
  "points": scoreEngagement,
}];

// Add a legend
chart.legend = new am4charts.Legend();
