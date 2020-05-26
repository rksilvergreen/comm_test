import 'package:flutter/material.dart';

/// ##########################################################
/// ################### Responsive Grid ######################
/// ##########################################################

class ResponsiveGrid extends StatefulWidget {
  final ResponsiveColumn child;
  final BorderSide borderData;
  final double width;
  final double height;
  final bool stretch;

  ResponsiveGrid(
      {@required this.child,
      this.borderData,
      this.width,
      this.height,
      this.stretch = false}) {

    child.isLast = true;
  }

  @override
  _ResponsiveGridState createState() => _ResponsiveGridState();
}

class _ResponsiveGridState extends State<ResponsiveGrid> {
  @override
  Widget build(BuildContext context) {
    return BorderData(
        border: widget.borderData != null ? widget.borderData : BorderSide(width: 0, color: Colors.transparent),
        child: StretchContainer(
            stretch: widget.stretch,
            initWidth: widget.width,
            initHeight: widget.height,
            decoration: widget.borderData != null
                ? BoxDecoration(
                    border: Border(
                    top: widget.borderData,
                    bottom: widget.borderData,
                    left: widget.borderData,
                    right: widget.borderData,
                  ))
                : null,
            child: widget.child));
  }
}

class StretchContainer extends StatefulWidget {
  final double initWidth;
  final double initHeight;
  final bool stretch;
  final Decoration decoration;
  final ResponsiveColumn child;

  StretchContainer(
      {this.stretch,
      this.initWidth,
      this.initHeight,
      this.decoration,
      this.child});

  @override
  _StretchContainerState createState() => _StretchContainerState();
}

class _StretchContainerState extends State<StretchContainer> {
  double _updatedWidth;
  double _updatedHeight;
  double _currWidth;
  double _currHeight;

  @override
  void initState() {
    super.initState();
    _updatedWidth = widget.initWidth;
    _updatedHeight = widget.initHeight;
    _currWidth = _updatedWidth;
    _currHeight = _updatedHeight;
  }

  @override
  Widget build(BuildContext context) {
    BorderSide borderData = BorderData.of(context);
    return GestureDetector(
      onScaleUpdate: (scaleUpdates) {
        if (widget.stretch) {
          setState(() {
            _currWidth = _updatedWidth * scaleUpdates.horizontalScale;
            _currHeight = _updatedHeight * scaleUpdates.verticalScale;
          });
        }
      },
      onScaleEnd: (scaleUpdates) {
        _updatedWidth = _currWidth;
        _updatedHeight = _currHeight;
      },
      child: StretchData(
        width: _currWidth - borderData.width * 2,
        height: _currHeight - borderData.width * 2,
        child: Container(
            width: _currWidth,
            height: _currHeight,
            decoration: widget.decoration,
            child: widget.child),
      ),
    );
  }
}

class BorderData extends InheritedWidget {
  final Widget child;
  final BorderSide border;

  BorderData({this.border, this.child});

  static BorderSide of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BorderData) as BorderData)
        .border;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

class StretchData extends InheritedWidget {
  final double width;
  final double height;
  final Widget child;

  StretchData({@required this.width, @required this.height, this.child});

  static StretchData of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StretchData) as StretchData);
  }

  @override
  bool updateShouldNotify(StretchData oldWidget) {
    return (oldWidget.width != width || oldWidget.height != height);
  }
}

/// ##########################################################
/// ################## Responsive Column #####################
/// ##########################################################

class ResponsiveColumn extends StatefulWidget {
  bool isLast;
  final List<ResponsiveRow> children;
  final List<RelativeSizeSegment> Function (double w, double h, double r) relativeWidthFunction;
  final Widget Function (double w, double h, double r) widget;

  ResponsiveColumn(this.relativeWidthFunction,
      {this.children, this.widget});

  @override
  _ResponsiveColumnState createState() => _ResponsiveColumnState();
}

class _ResponsiveColumnState extends State<ResponsiveColumn> {

  Width getWidth(context) {
    double _relativeWidthFunction(w,h,r) {
      return widget.relativeWidthFunction(w,h,r)
          .singleWhere(
              (seg) => (seg.from <= r && r < seg.to))
          .rel;
    }

    StretchData parentSizeData = StretchData.of(context);
    double parentWidth = parentSizeData.width;
    double parentHeight = parentSizeData.height;
    double parentRatio = parentWidth / parentHeight;
    double relativeWidth = _relativeWidthFunction(parentWidth, parentHeight, parentRatio);
    BorderSide borderData = BorderData.of(context);
    double width = parentWidth * relativeWidth;
    return Width(width, borderData);
  }

  hasChildren() {
    return widget.children != null
        ? widget.children.length > 0 ? true : false
        : false;
  }

  hasChild() {
    return widget.widget != null;
  }

  @override
  Widget build(BuildContext context) {
    BorderSide borderData = BorderData.of(context);
    StretchData parentSizeData = StretchData.of(context);
    Width width = getWidth(context);
    double height = parentSizeData.height;

    if (hasChildren())
      widget.children.asMap().forEach((i, child) {
        child.isLast = i == widget.children.length - 1;
      });

    return StretchData(
      width: width.withoutBorders,
      height: height,
      child: Container(
        width: width.withBorders,
        height: height,
        decoration: !widget.isLast
            ? BoxDecoration(border: Border(right: borderData))
            : BoxDecoration(),
        child: hasChild()
            ? widget.widget(width.withoutBorders, height, width.withoutBorders / height)
            : hasChildren() ? Column(children: widget.children) : Column(),
      ),
    );
  }
}

/// ##########################################################
/// #################### Responsive Row ######################
/// ##########################################################

class ResponsiveRow extends StatefulWidget {
  bool isLast;
  final List<ResponsiveColumn> children;
  final List<RelativeSizeSegment> Function (double w, double h, double r) relativeWidthFunction;
  final Widget Function (double w, double h, double r) widget;

  ResponsiveRow(
  this.relativeWidthFunction,
      {this.children,
      this.widget});

  @override
  _ResponsiveRowState createState() => _ResponsiveRowState();
}

class _ResponsiveRowState extends State<ResponsiveRow> {

  Height getHeight(context) {
    double _relativeHeightFunction(w,h,r) {
      return widget.relativeWidthFunction(w,h,r)
          .singleWhere((seg) =>
              (seg.from <= r && r < seg.to))
          .rel;
    }

    StretchData parentSizeData = StretchData.of(context);
    double parentWidth = parentSizeData.width;
    double parentHeight = parentSizeData.height;
    double parentRatio = parentWidth / parentHeight;
    double relativeHeight = _relativeHeightFunction(parentWidth, parentHeight, parentRatio);
    BorderSide borderData = BorderData.of(context);
    double height = relativeHeight * parentHeight;
    return Height(height, borderData);
  }

  hasChildren() {
    return widget.children != null
        ? widget.children.length > 0 ? true : false
        : false;
  }

  hasChild() {
    return widget.widget != null;
  }

  @override
  Widget build(BuildContext context) {
    BorderSide borderData = BorderData.of(context);
    StretchData parentSizeData = StretchData.of(context);
    double width = parentSizeData.width;
    Height height = getHeight(context);

    if (hasChildren())
      widget.children.asMap().forEach((i, child) {
        child.isLast = i == widget.children.length - 1;
      });

    return StretchData(
      width: width,
      height: height.withoutBorders,
      child: Container(
        width: width,
        height: height.withBorders,
        decoration: !widget.isLast
            ? BoxDecoration(border: Border(bottom: borderData))
            : BoxDecoration(),
        child: hasChild()
            ? widget.widget(width, height.withoutBorders, width / height.withoutBorders)
            : hasChildren() ? Row(children: widget.children) : Row(),
      ),
    );
  }
}

class CellConstraints extends StatefulWidget {

  final Function fun;

  CellConstraints(this.fun);

  @override
  _CellConstraintsState createState() => _CellConstraintsState();
}

class _CellConstraintsState extends State<CellConstraints> {
  @override
  Widget build(BuildContext context) {
    StretchData parentSizeData = StretchData.of(context);
    double width = parentSizeData.width;
    double height = parentSizeData.height;
    double ratio = width / height;

    return widget.fun(width, height, ratio);
  }
}


/// ##########################################################
/// ################### Resize Segment #######################
/// ##########################################################

class RelativeSizeSegment {
  double from;
  double to;
  final double rel;

  RelativeSizeSegment({this.from = 0, this.to = double.infinity, @required this.rel});
}

/// ##########################################################
/// ######################## Aux #############################
/// ##########################################################

class Width {
  double _withBorders;
  double _withoutBorders;

  Width(double width, BorderSide borderData) {
    _withBorders = width;
    double borderWidth = borderData != null ? borderData.width : 0;
    _withoutBorders = width - borderWidth;
  }

  get withBorders {
    return _withBorders;
  }

  get withoutBorders {
    return _withoutBorders;
  }
}

class Height {
  double _withBorders;
  double _withoutBorders;

  Height(double height, BorderSide borderData) {
    _withBorders = height;
    double borderWidth = borderData != null ? borderData.width : 0;
    _withoutBorders = height - borderWidth;
  }

  get withBorders {
    return _withBorders;
  }

  get withoutBorders {
    return _withoutBorders;
  }
}
