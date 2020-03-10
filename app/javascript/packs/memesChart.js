/* Imports */
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";
import * as am4plugins_forceDirected from "@amcharts/amcharts4/plugins/forceDirected";

// Get api data
const chartDiv = document.getElementById("js-meme-chart");
const userId = chartDiv.dataset["userId"];
const userName = chartDiv.dataset["username"];

const createApiUrl = () => {
  if (environment) {
    let apiUrl = 'https://meme-forest.herokuapp.com/api/v1/users/';
    return `${apiUrl}${userId}`
  } else {
    const apiUrl = 'http://localhost:3000/api/v1/users/'
    return `${apiUrl}${userId}/stats`
  }
}

/* Chart code */
let chart = am4core.create("js-meme-chart", am4plugins_forceDirected.ForceDirectedTree);
let networkSeries = chart.series.push(new am4plugins_forceDirected.ForceDirectedSeries())

chart.dataSource.url = createApiUrl();

// for later refresh purposes:
// chart.dataSource.reloadFrequency = 5000;

networkSeries.dataFields.value = "value";
networkSeries.dataFields.name = "name";
networkSeries.dataFields.children = "children";
networkSeries.nodes.template.tooltipText = "{name}:{value}";
networkSeries.nodes.template.fillOpacity = 1;

networkSeries.nodes.template.label.text = "{name}"
networkSeries.fontSize = 12;

networkSeries.links.template.strokeWidth = 1;

let hoverState = networkSeries.links.template.states.create("hover");
hoverState.properties.strokeWidth = 3;
hoverState.properties.strokeOpacity = 1;

networkSeries.nodes.template.events.on("over", function(event) {
  event.target.dataItem.childLinks.each(function(link) {
    link.isHover = true;
  })
  if (event.target.dataItem.parentLink) {
    event.target.dataItem.parentLink.isHover = true;
  }

})

networkSeries.nodes.template.events.on("out", function(event) {
  event.target.dataItem.childLinks.each(function(link) {
    link.isHover = false;
  })
  if (event.target.dataItem.parentLink) {
    event.target.dataItem.parentLink.isHover = false;
  }
})


