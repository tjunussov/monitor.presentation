var options = {
	chart: {
        zoomType: 'xy',
        spacingBottom: 12,
		backgroundColor : 'transparent'/*,
		alignTicks: false*/
    },
    title: {
        text: ''
    },
    lang:{thousandsSep:' '},
    xAxis: [{
    	tickPixelInterval :70,
		tickLength : 0,
		lineWidth : 1,
		gridLineWidth: 1,
		gridLineColor:'#444',
		labels:{style:{color:'#fff',fontSize:10,fontWeight:'bold',fontFamily:'Arial'}, y: 30},
        categories: [],		
    }],
    yAxis: [{ // Primary yAxis
        title: {
            text: '',
            style:{color:Highcharts.getOptions().colors[1],fontSize:10,fontWeight:'bold',fontFamily:'Arial'}
        },labels: {
            style:{color:'#777',fontSize:10,fontWeight:'bold',fontFamily:'Arial'},
            y:3
        },
	    tickPixelInterval : '50',
		tickWidth : 1,
		tickLength : 0,
		tickColor : '#444',
		gridLineColor:'#444',
		maxZoom :1,
		min: 0
    }, { // Secondary yAxis
        title: {
            text: '',
            style:{color:'#777',fontSize:10,fontWeight:'bold',fontFamily:'Arial'}
        },
        labels: {
            style: {color: 'rgba(255,180,0,.5)'},
			y:3
        },	        
        tickPixelInterval : '50',
		tickWidth : 1,
		tickLength : 0,
		tickColor : '#444',
		gridLineColor:'#444',
		maxZoom :1,
		min: 0,
		opposite: true
    }],
    tooltip: {
        shared: true
    },
    legend: {
        layout: 'vertical',
        align: 'right',
        x: -80,
        verticalAlign: 'top',
        y: 10,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
    },
    plotOptions: {
    	/*series: {
                stacking: 'normal'
        },*/
		column: {
			groupPadding: 0.1,
			borderWidth: 0,
			borderRadius : 0,
			cursor:'hand',
			animation:true,
			dataLabels: {
				enabled: true,
				color: '#fff',
				formatter: function() {	return this.y;}
			},
			events: {
                click: function(evt) {
                    console.log("report clicked",evt.point.category + ":" +  evt.point.y + ":" + this.name);
                }
            }	
		},
		pie: {
			pointPadding: 0,
			borderWidth: 0,
			borderRadius : 0,
			cursor:'hand',
			animation:true,
			dataLabels: {
				enabled: true,
				color: '#fff',
				formatter: function() { return this.key + ' - <b>' + this.y + '</b>';}
			},
			events: {
                click: function(evt) {
                    console.log("report clicked",evt.point.category + ":" +  evt.point.y + ":" + this.name);
                }
            },
            showInLegend: true	
		},
		bar: {
			stacking: 'normal',
			pointPadding: 0,
			borderWidth: 0,
			borderRadius : 0,
			cursor:'hand',
			animation:true,
			dataLabels: {
				enabled: false/*,
				color: '#fff',
				formatter: function() {	return this.y;}*/
			},
			events: {
	            click: function(evt) {
	                console.log("report clicked",evt.point.category + ":" +  evt.point.y + ":" + this.name);
	            }
	        }
		},
		line: {
			pointPadding: 0,
			borderWidth: 0,
			borderRadius : 0,
			cursor:'hand',
			animation:true,
			dataLabels: {
				enabled: true,
				color: '#fff',
				formatter: function() {	return this.y;}
			}
		},
		area: {
            fillColor: {
                linearGradient: {
                    x1: 0,
                    y1: 0,
                    x2: 0,
                    y2: 1
                },
                stops: [
                    [0, Highcharts.getOptions().colors[0]],
                    [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                ]
            },
            marker: {
                radius: 2
            },
            lineWidth: 1,
            states: {
                hover: {
                    lineWidth: 1
                }
            },
            threshold: null
        },
        areaspline: {
            fillOpacity: 0.5
        }
	},
	credits: {enabled: false},
    series: []
}


var bar_options = {
	yAxis: { // Primary yAxis
	    stackLabels: {
	        enabled: true,
	        style:{color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray',fontSize:10,fontWeight:'bold',fontFamily:'Arial'}
	     },
	    title: {
	        text: 'Кол-во',
	        style: {
	            color: Highcharts.getOptions().colors[1]
	        }
	    },
	    tickPixelInterval : '50',
		tickWidth : 1,
		tickLength : 0,
		tickColor : '#444',
		gridLineColor:'#444',
		maxZoom :1,
		min: 0
	}
};