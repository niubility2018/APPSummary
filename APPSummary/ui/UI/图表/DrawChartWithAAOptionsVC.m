//
//  DrawChartWithAAOptionsVC.m
//  AAChartKit
//
//  Created by An An on 2017/8/9.
//  Copyright © 2017年 An An. All rights reserved.
//

#import "DrawChartWithAAOptionsVC.h"
#import "AAChartKit.h"
//#import "AATitle.h"
//#import "AASubtitle.h"

@interface DrawChartWithAAOptionsVC ()

@end

@implementation DrawChartWithAAOptionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    AAChartView *chartView =[[AAChartView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    chartView.contentHeight = chartView.frame.size.height-60;
    [self.view addSubview:chartView];
    chartView.scrollEnabled = NO;
    
    if (self.selectedIndex == 0) {
        AAOptions *areaChartOptions = [self configureTheAAOptionsOfAreaChart];
        [chartView aa_drawChartWithOptions:areaChartOptions];
    } else if (self.selectedIndex == 1) {
        AAOptions *pieChartOptions = [self configureTheAAOptionsOfPieChart];
        [chartView aa_drawChartWithOptions:pieChartOptions];
    } else {
        AAOptions *chartOptions = [self configureTheAAOptionsOfSpecialNestedColumnChart];
        [chartView aa_drawChartWithOptions:chartOptions];
    }
    
}

- (AAOptions *)configureTheAAOptionsOfAreaChart {
/*===============================================================原生 JavaScript 代码==============================================================
    <html>
    <head>
    <meta charset="UTF-8" />
    <title>Highcharts 原生 HTML 代码</title>
    <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    </head>
    <body>
    <div id="container" style="width: 550px; height: 400px; margin: 0 auto"></div>
    <script language="JavaScript">
    $(document).ready(function() {
        var title = {
        text: 'AAChartKit'
        };
        var subtitle = {
        text: 'Source: https://github.com/AAChartModel/AAChartKit'
        };
        var xAxis = {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                     'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        };
        var yAxis = {
        title: {
        text: 'Temperature (\xB0C)'
        },
        plotLines: [{
        value: 0,
        width: 1,
        color: '#808080'
        }]
        };
 
        var tooltip = {
        valueSuffix: '\xB0C'
        }
 
        var legend = {
        layout: 'vertical',
        align: 'center',
        verticalAlign: 'top',
        borderWidth: 0
        };
 
        var series =  [
                       {
                       name: 'Tokyo',
                       data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2,
                              26.5, 23.3, 18.3, 13.9, 9.6]
                       },
                       {
                       name: 'New York',
                       data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8,
                              24.1, 20.1, 14.1, 8.6, 2.5]
                       },
                       {
                       name: 'London',
                       data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0,
                              16.6, 14.2, 10.3, 6.6, 4.8]
                       }
                       ];
 
        var json = {};
 
        json.title = title;
        json.subtitle = subtitle;
        json.xAxis = xAxis;
        json.yAxis = yAxis;
        json.tooltip = tooltip;
        json.legend = legend;
        json.series = series;
 
        $('#container').highcharts(json);
    });
    </script>
    </body>
    </html>
 

 
===============================================================原生 JavaScript 代码==============================================================*/
    
   
/****************************************************参照原生 JavaScript 代码仿写构建生成 AAOptions 实例对象(方法1)****************************************************/
    NSDictionary *chart = @{@"type":@"area"};
    
    //标题
    NSDictionary *title = @{@"text":@"AAChartKit"};
    
    //副标题
    NSDictionary *subtitle = @{@"subtitle":@"Source: https://github.com/AAChartModel/AAChartKit"};
    
    //X轴
    NSDictionary *xAxis = @{
                           @"categories": @[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun",
                                            @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"]
                           };
    
    //Y轴
    NSDictionary *yAxis = @{
                           @"title":@{
                                   @"text":@"Temperature (xB0C)"
                                   },
                           @"plotLines":@[@{
                                              @"value":@0,
                                              @"width":@1,
                                              @"color":@"#808080"
                                              }]
                           
                           };
    
    //浮动提示框
    NSDictionary *tooltip = @{
                              @"valueSuffix": @"xB0C"
                              };
    
    //图例
    NSDictionary *legend = @{
                             @"layout": @"vertical",
                             @"align": @"right",
                             @"verticalAlign": @"top",
                             @"borderWidth": @0
                             };
    
    //数据源
    NSArray *series = @[
                        @{
                            @"name": @"Tokyo",
                            @"data": @[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2,
                                       @26.5, @23.3, @18.3, @13.9, @9.6]
                            },
                        @{
                            @"name": @"New York",
                            @"data": @[@-0.2, @0.8, @5.7, @11.3, @17.0, @22.0, @24.8,
                                         @24.1, @20.1, @14.1, @8.6, @2.5]
                            },
                        @{
                            @"name": @"London",
                            @"data": @[@3.9, @4.2, @5.7, @8.5, @11.9, @15.2, @17.0,
                                       @16.6, @14.2, @10.3, @6.6, @4.8]
                            }
                        ];

    
    NSArray *colors = @[@"#b5282a",@"#e7a701",@"#50c18d",@"#fd4800",@"#f1c6c5"];
    
//第一种写法
    AAOptions *options = AAObject(AAOptions);
    options.chart = (id)chart;
    options.title = (id)title;
    options.subtitle = (id)subtitle;
    options.xAxis = (id)xAxis;
    options.yAxis = (id)yAxis;
    options.tooltip = (id)tooltip;
    options.legend = (id)legend;
    options.series = (id)series;
    options.colors = colors;
    
    
//    另一种写法
//    AAOptions *options = AAObject(AAOptions)
//    .chartSet((id)chart)
//    .titleSet((id)title)
//    .subtitleSet((id)subtitle)
//    .xAxisSet((id)xAxis)
//    .yAxisSet((id)yAxis)
//    .tooltipSet((id)tooltip)
//    .legendSet((id)legend)
//    .seriesSet((id)series)
//    .colorsSet(colors)
//    ;
    


/****************************************************参照原生 JavaScript 代码仿写构建生成 AAOptions 实例对象(方法1)****************************************************/
    
    
    return options;


}

- (AAOptions *)configureTheAAOptionsOfPieChart {
//    //第一种写法
////    //图表类型
//    AAChart *aaChart = AAObject(AAChart)
//    .typeSet(AAChartTypePie);
//
//    //标题
//    AATitle *aaTitle = AAObject(AATitle)
//    .textSet(@"渠道销售额<br>占比")//标题文本内容
//    .alignSet(AAChartTitleAlignTypeCenter)//标题水平居中
//    .verticalAlignSet(AAChartTitleVerticalAlignTypeMiddle)//标题垂直居中
//    .styleSet(AAObject(AAStyle)
//              .colorSet(@"#000000")//Title font color
//              .fontSizeSet(@"14 px")//Title font size
//              .fontWeightSet(@"bold")//Title font weight
//              );
//
//    AAPlotOptions *aaPlotOptions = (AAObject(AAPlotOptions)
//                                    .seriesSet(AAObject(AASeries)
//                                               .animationSet(AAObject(AAAnimation)
//                                                             .easingSet(@"bounce")
//                                                             .durationSet(@1000)
//                                                             )
//                                               )
//                                    .pieSet(AAObject(AAPie)
//                                            .showInLegendSet(true)
//                                            .dataLabelsSet(AAObject(AADataLabels)
//                                                           .enabledSet(true)
//                                                           .formatSet(@"{point.percentage:.1f}%"))
//                                            )
//                                    );
//
//    //数据源
//    NSArray *aaSeries = @[
//                        AAObject(AASeriesElement)
//                        .nameSet(@"语言热度值")
//                        .innerSizeSet(@"80%")//内部圆环半径大小占比
//                        .allowPointSelectSet(false)//是否允许在点击数据点标记(扇形图点击选中的块发生位移)
//                        .dataSet(
//                                 @[
//                                   @[@"Firefox",   @3336.2],
//                                   @[@"IE",        @26.8],
//                                   @[@"Safari",    @88.5],
//                                   @[@"Opera",     @46.0],
//                                   @[@"Others",    @223]
//                                   ]
//                                 ),
//                        ];
//
//    NSArray *aaColors = @[@"#b5282a",@"#e7a701",@"#50c18d",@"#fd4800",@"#f1c6c5"];
//
//    AAOptions *aaOptions = AAObject(AAOptions);
//    aaOptions.chart = aaChart;
//    aaOptions.title = aaTitle;
//    aaOptions.plotOptions = aaPlotOptions;
//    aaOptions.series = aaSeries;
//    aaOptions.colors = aaColors;
    
    
//    另一种写法
    AAOptions *aaOptions = AAObject(AAOptions)
    .chartSet(AAObject(AAChart)
              .typeSet(AAChartTypePie))
    .titleSet(AAObject(AATitle)
              .textSet(@"渠道销售额<br>占比")//标题文本内容
              .alignSet(AAChartTitleAlignTypeCenter)//标题水平居中
              .verticalAlignSet(AAChartTitleVerticalAlignTypeMiddle)//标题垂直居中
              .styleSet(AAObject(AAStyle)
                        .colorSet(@"#000000")//Title font color
                        .fontSizeSet(@"14 px")//Title font size
                        .fontWeightSet(@"bold")//Title font weight
                        )
              )
    .plotOptionsSet(AAObject(AAPlotOptions)
                    .seriesSet(AAObject(AASeries)
                               .animationSet(AAObject(AAAnimation)
                                             .easingSet(@"bounce")
                                             .durationSet(@1000)
                                             )
                               )
                    .pieSet(AAObject(AAPie)
                            .showInLegendSet(true)
                            .dataLabelsSet(AAObject(AADataLabels)
                                           .enabledSet(false)
//                                           .formatSet(@"{point.percentage:.1f}%")
                                           )
                            )
                    )
    .legendSet(AAObject(AALegend)
               .enabledSet(true)
               .verticalAlignSet(AALegendVerticalAlignTypeTop)
               .layoutSet(AALegendLayoutTypeVertical)
               .alignSet(AALegendAlignTypeCenter)
               )
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"语言热度值")
//                 .sizeSet(@300)//环形图的半径大小
                 .innerSizeSet(@"60%")//内部圆环半径大小占比
                 .allowPointSelectSet(false)//是否允许在点击数据点标记(扇形图点击选中的块发生位移)
                 .dataSet(
                          @[
                            @[@"Firefox",   @3336.2],
                            @[@"IE",        @26.8],
                            @[@"Safari",    @88.5],
                            @[@"Opera",     @46.0],
                            @[@"Others",    @223]
                            ]
                          ),
                 ])
    .colorsSet(@[@"#1E90FF",@"#e7a701",@"#50c18d",@"#fd4800",@"#F4A460"]);//设置颜色主题
    return aaOptions;
}

- (AAOptions *)configureTheAAOptionsOfSpecialNestedColumnChart {
    //第一种写法
//    AAChart *aaChart = AAObject(AAChart)
//    .typeSet(AAChartTypeColumn);
//
//    AATitle *aaTitle = AAObject(AATitle)
//    .textSet(@"分公司效率优化嵌套图");
//
//    AAXAxis *aaXAxis = AAObject(AAXAxis)
//    .categoriesSet(@[@"伦敦总部",@"柏林分部",@"纽约分部",]);
//
//    AAYAxis *aaYAxis1 =
//    AAObject(AAYAxis)
//    .visibleSet(true)
//    .minSet(0)
//    .titleSet(AAObject(AATitle)
//              .textSet(@"雇员"));
//
//    AAYAxis *aaYAxis2 =
//    AAObject(AAYAxis)
//    .visibleSet(true)
//    .titleSet(AAObject(AATitle)
//              .textSet(@"利润 (millions)"))
//    .oppositeSet(true);
//
//    AATooltip *aaTooltip = AAObject(AATooltip).sharedSet(true);
//    AAPlotOptions *aaPlotOptions = AAObject(AAPlotOptions)
//    .seriesSet(AAObject(AASeries)
//               .animationSet(AAObject(AAAnimation)
//                             .easingSet(@"bounce")
//                             .durationSet(@1000)
//                             )
//               )
//    .columnSet(AAObject(AAColumn)
//               .groupingSet(false)
//               .borderWidthSet(@0));
//
//    NSArray *aaSeries = @[@{
//                               @"name": @"雇员",
//                               @"color": @"rgba(165,170,217,1)",
//                               @"data": @[@150, @73, @20],
//                               @"pointPadding": @0.3,
//                               @"pointPlacement": @-0.2
//                               }, @{
//                               @"name": @"优化的员工",
//                               @"color": @"rgba(126,86,134,.9)",
//                               @"data": @[@140, @90, @40],
//                               @"pointPadding": @0.4,
//                               @"pointPlacement": @-0.2
//                               }, @{
//                               @"name": @"利润",
//                               @"color": @"rgba(248,161,63,1)",
//                               @"data": @[@183.6, @178.8, @198.5],
//                               @"tooltip": @{
//                                   @"valuePrefix": @"$",
//                                   @"valueSuffix": @" M"
//                               },
//                               @"pointPadding": @0.3,
//                               @"pointPlacement": @0.2,
//                               @"yAxis": @1
//                               }, @{
//                               @"name": @"优化的利润",
//                               @"color": @"rgba(186,60,61,.9)",
//                               @"data": @[@203.6, @198.8, @208.5],
//                               @"tooltip": @{
//                                       @"valuePrefix": @"$",
//                                       @"valueSuffix": @" M"
//                                       },
//                               @"pointPadding": @0.4,
//                               @"pointPlacement": @0.2,
//                               @"yAxis": @1
//                               }];
//
//    AAOptions *aaOptions = AAObject(AAOptions);
//    aaOptions.chart = aaChart;
//    aaOptions.title = aaTitle;
//    aaOptions.xAxis = aaXAxis;
//    aaOptions.yAxis = (id)@[aaYAxis1,aaYAxis2];
//    aaOptions.tooltip = aaTooltip;
//    aaOptions.plotOptions = aaPlotOptions;
//    aaOptions.series = aaSeries;
    
    //    另一种写法
    
    AAOptions *aaOptions = AAObject(AAOptions)
    .chartSet(AAObject(AAChart)
              .typeSet(AAChartTypeColumn))
    .titleSet(AAObject(AATitle)
              .textSet(@"分公司效率优化嵌套图"))
    .xAxisSet(AAObject(AAXAxis)
              .categoriesSet(@[@"伦敦总部",@"柏林分部",@"纽约分部",]))
    .yAxisSet((id)@[AAObject(AAYAxis)
                    .visibleSet(true)
                    .minSet(0)
                    .titleSet(AAObject(AATitle)
                              .textSet(@"雇员")),
                    AAObject(AAYAxis)
                    .visibleSet(true)
                    .titleSet(AAObject(AATitle)
                              .textSet(@"利润 (millions)"))
                    .oppositeSet(true)
                    ])
    .tooltipSet(AAObject(AATooltip)
                .sharedSet(true))
    .plotOptionsSet(AAObject(AAPlotOptions)
                    .seriesSet(AAObject(AASeries)
                               .animationSet(AAObject(AAAnimation)
                                             .easingSet(@"bounce")
                                             .durationSet(@1000)
                                             )
                               )
                    .columnSet(AAObject(AAColumn)
                               .groupingSet(false)
                               .borderWidthSet(@0)))
    .seriesSet(@[@{
                     @"name": @"雇员",
                     @"color": @"rgba(165,170,217,1)",
                     @"data": @[@150, @73, @20],
                     @"pointPadding": @0.3,
                     @"pointPlacement": @-0.2
                     }, @{
                     @"name": @"优化的员工",
                     @"color": @"rgba(126,86,134,.9)",
                     @"data": @[@140, @90, @40],
                     @"pointPadding": @0.4,
                     @"pointPlacement": @-0.2
                     }, @{
                     @"name": @"利润",
                     @"color": @"rgba(248,161,63,1)",
                     @"data": @[@183.6, @178.8, @198.5],
                     @"tooltip": @{
                             @"valuePrefix": @"$",
                             @"valueSuffix": @" M"
                             },
                     @"pointPadding": @0.3,
                     @"pointPlacement": @0.2,
                     @"yAxis": @1
                     }, @{
                     @"name": @"优化的利润",
                     @"color": @"rgba(186,60,61,.9)",
                     @"data": @[@203.6, @198.8, @208.5],
                     @"tooltip": @{
                             @"valuePrefix": @"$",
                             @"valueSuffix": @" M"
                             },
                     @"pointPadding": @0.4,
                     @"pointPlacement": @0.2,
                     @"yAxis": @1
                     }]);
    
    return aaOptions;
 
}

@end
