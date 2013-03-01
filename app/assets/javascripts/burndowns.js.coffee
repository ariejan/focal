google.load "visualization", "1", { packages: ["corechart"] }
google.setOnLoadCallback () ->
  chartData = [['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected'],
  ['2013-02-25 13:46:48 +0000', 28, 6,  0, 0, 0,  0],
  ['2013-02-26 05:02:00 +0000', 23, 10,  1, 0, 0,  0],
  ['2013-02-27 08:24:07 +0000', 18, 13,  0, 3, 0,  0],
  ['2013-02-28 05:00:19 +0000', 14, 5,  2, 10, 3,  0],
  ['2013-03-01 08:24:23 +0000', 10, 8,  1, 11, 4,  0]]

  data = google.visualization.arrayToDataTable(chartData)

  options = {
    isStacked: true,
    hAxis: { title: "Day" } 
  }

  chart = new google.visualization.ColumnChart(document.getElementById('burndown-chart'))
  chart.draw(data, options)
