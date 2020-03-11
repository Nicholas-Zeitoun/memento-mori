/* Imports */
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";
import am4themes_animated from "@amcharts/amcharts4/themes/animated";

// Retrieve user's latest memes infos
const chartDiv = document.getElementById("js-meme-chart");
const meme1 = JSON.parse(chartDiv.dataset["meme1"]);
const meme2 = JSON.parse(chartDiv.dataset["meme2"]);
const meme3 = JSON.parse(chartDiv.dataset["meme3"]);
const meme4 = JSON.parse(chartDiv.dataset["meme4"]);
const meme5 = JSON.parse(chartDiv.dataset["meme5"]);
const meme6 = JSON.parse(chartDiv.dataset["meme6"]);
const meme7 = JSON.parse(chartDiv.dataset["meme7"]);

/* Chart code */
// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end
// #535353


let chart = am4core.create("js-meme-chart", am4charts.XYChart);
chart.hiddenState.properties.opacity = 0; // this creates initial fade-in

chart.paddingBottom = 50;
chart.paddingTop = 30;
chart.paddingRight = 30;
chart.paddingLeft = 10;

chart.data = [{
    "name": meme1["name"],
    "steps": meme1["steps"],
    "href": meme1["href"]
}, {
    "name": meme2["name"],
    "steps": meme2["steps"],
    "href": meme2["href"]
}, {
    "name": meme3["name"],
    "steps": meme3["steps"],
    "href": meme3["href"]
}, {
    "name": meme4["name"],
    "steps": meme4["steps"],
    "href": meme4["href"]
}, {
    "name": meme5["name"],
    "steps": meme5["steps"],
    "href": meme5["href"]
}, {
    "name": meme6["name"],
    "steps": meme6["steps"],
    "href": meme6["href"]
}, {
    "name": meme7["name"],
    "steps": meme7["steps"],
    "href": meme7["href"]
}];

let categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "name";
categoryAxis.renderer.grid.template.strokeOpacity = 0;
categoryAxis.renderer.minGridDistance = 20;
categoryAxis.renderer.labels.template.dy = 45;
categoryAxis.renderer.labels.template.fill = am4core.color("#39095F");
categoryAxis.cursorTooltipEnabled = false;

let valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.inside = false;
valueAxis.renderer.labels.template.fillOpacity = 0.3;
valueAxis.renderer.grid.template.strokeOpacity = 0;
valueAxis.min = 0;
// valueAxis.renderer.minGridDistance = 20;
valueAxis.cursorTooltipEnabled = false;
valueAxis.renderer.baseGrid.strokeOpacity = 0;

let series = chart.series.push(new am4charts.ColumnSeries);
series.dataFields.valueY = "steps";
series.dataFields.categoryX = "name";
series.tooltipText = "{valueY.value}";
// series.tooltip.background.fill = am4core.color("#87629A");
series.tooltip.pointerOrientation = "vertical";
series.tooltip.dy = - 6;
series.columnsContainer.zIndex = 100;

let columnTemplate = series.columns.template;
columnTemplate.width = am4core.percent(40);
columnTemplate.maxWidth = 40;
columnTemplate.column.cornerRadius(2, 2, 0, 0);
columnTemplate.strokeOpacity = 0;
// columnTemplate.column.fill = am4core.color("#87629A"); // fill

series.heatRules.push({ target: columnTemplate, property: "fill", dataField: "valueY", min: am4core.color("#87629A"), max: am4core.color("#39095F") });
series.mainContainer.mask = undefined;

let cursor = new am4charts.XYCursor();
chart.cursor = cursor;
cursor.lineX.disabled = true;
cursor.lineY.disabled = true;
cursor.behavior = "none";

let bullet = columnTemplate.createChild(am4charts.CircleBullet);
bullet.circle.radius = 20;
// bullet.fill = am4core.color("#39095F");
bullet.valign = "bottom";
bullet.align = "center";
bullet.isMeasured = true;
bullet.mouseEnabled = false;
bullet.verticalCenter = "bottom";
bullet.interactionsEnabled = false;

let hoverState = bullet.states.create("hover");
let outlineCircle = bullet.createChild(am4core.Circle);
outlineCircle.adapter.add("radius", function (radius, target) {
    let circleBullet = target.parent;
    return circleBullet.circle.pixelRadius + 8;
})

let image = bullet.createChild(am4core.Image);
image.width = 100;
image.height = 100;
image.horizontalCenter = "middle";
image.verticalCenter = "middle";
image.propertyFields.href = "href";

image.adapter.add("mask", function (mask, target) {
    let circleBullet = target.parent;
    return circleBullet.circle;
})

let previousBullet;
chart.cursor.events.on("cursorpositionchanged", function (event) {
    let dataItem = series.tooltipDataItem;

    if (dataItem.column) {
        let bullet = dataItem.column.children.getIndex(1);

        if (previousBullet && previousBullet != bullet) {
            previousBullet.isHover = false;
        }

        if (previousBullet != bullet) {

            let hs = bullet.states.getKey("hover");
            hs.properties.dy = -bullet.parent.pixelHeight + 30;
            bullet.isHover = true;

            previousBullet = bullet;
        }
    }
})
