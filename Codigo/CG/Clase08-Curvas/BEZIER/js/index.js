BC = {
  grid: 25,
  pause: false,
  play: true,
  stepped: false,
  padding: 12.5,
  speed: 5000,
  points: [{ x: 2, y: 12 }, { x: 5, y: 2 }, { x: 8, y: 5 }, { x: 9, y: 16 }, { x: 11, y: 2 }, { x: 15, y: 8 }],
  pointsRaw: function() {
    return $('#st .points .point');
  },
  updatePoints: function() {
    var points = this.pointsRaw();
    var minuses = this.pointsRaw().find('.minus');
        minuses.attr('disabled', minuses.length == 1);
    
    for (var i = 0; i < points.length; i++) {
      $(points[i]).find('.add-on:first').text('P' + i + ': x');
    }
  },
  buildFromPoints: function() {
    var point = this.pointsCont.find('.point:first').clone();
    this.pointsCont.empty();
    for (var i = 0; i < this.points.length; i++) {
      point.find('.add-on:first').text('P' + i + ': x');
      point.find('input.x').val(this.points[i]['x'] / this.grid);
      point.find('input.y').val(this.points[i]['y'] / this.grid);

      $(point.clone()).appendTo(this.pointsCont);
    }
  },
  rebuild: function() {
    $('#vis').empty();

    var _ = this;
  
    _.w = 0;
    _.h = 0;
    _.t = 0;
    _.delta = .01;
    _.bezier = {};
    _.line = d3.svg.line().x(_.x).y(_.y);
    _.stroke = d3.scale.category20b();
    _.orders = _.stepped ? d3.range(2, _.points.length + 1) : [_.points.length];

    for (var i = 0; i < _.points.length; i++) {
      _.w = _.points[i]['x'] > _.w ? _.points[i]['x'] : _.w;
      _.h = _.points[i]['y'] > _.h ? _.points[i]['y'] : _.h;
    }

    _.vis = d3.select("#vis").selectAll("svg")
      .data(_.orders)
      .enter().append("svg")
      .attr("width", _.w + 2 * _.padding + 50)
      .attr("height", _.h + 2 * _.padding + 50)
      .append("g")
      .attr("transform", "translate(" + _.padding + "," + _.padding + ")");

    _.update();

    _.vis.selectAll("circle.control")
      .data(function (d) {
        return _.points.slice(0, d)
      })
      .enter().append("circle")
      .attr("class", "control")
      .attr("r", 7)
      .attr("cx", _.x)
      .attr("cy", _.y)
      .call(d3.behavior.drag()
        .on("dragstart", function (d) {
          this.__origin__ = [d.x, d.y];
        })
        .on("drag", function (d) {
          d.x = Math.min(_.w, Math.max(0, this.__origin__[0] += d3.event.dx));
          d.y = Math.min(_.h, Math.max(0, this.__origin__[1] += d3.event.dy));
          bezier = {};
          update();
          vis.selectAll("circle.control")
            .attr("cx", _.x)
            .attr("cy", _.y);
        })
        .on("dragend", function () {
          delete this.__origin__;
        })
      );

    _.vis.append("text")
      .attr("class", "t")
      .attr("x", _.w / 2)
      .attr("y", _.h)
      .attr("text-anchor", "middle");

    _.vis.selectAll("text.controltext")
      .data(function (d) {
        return _.points.slice(0, d);
      })
      .enter().append("text")
      .attr("class", "controltext")
      .attr("dx", "10px")
      .attr("dy", ".4em")
      .text(function (d, i) {
        return "P" + i + '(' + _.points[i]['x'] / _.grid + ',' + _.points[i]['y'] / _.grid + ')'
      });

    var last = 0;
    d3.timer(function (elapsed) {
      if (!_.pause) {
        if (!_.play) {
          if (_.t != 1) {
            last = 0;
            _.t = 1;
            _.update();
          }
        } else {
          _.t = (_.t + (elapsed - last) / _.speed) % 1;
          last = elapsed;
          _.update();
        }
      } else {
        last = elapsed;
      }
    });
  },
  update: function() {
    var _ = this;
    
    _.interpolation = _.vis.selectAll("g")
      .data(function (d) {
        return _.getLevels(d, _.t);
      });
    _.interpolation.enter().append("g")
      .style("fill", _.colour)
      .style("stroke", _.colour);

    var circle = _.interpolation.selectAll("circle")
      .data(Object);
    circle.enter().append("circle")
      .attr("r", 4);
    circle
      .attr("cx", _.x)
      .attr("cy", _.y);

    var path = _.interpolation.selectAll("path")
      .data(function (d) {
        return [d];
      });
    path.enter().append("path")
      .attr("class", "line")
      .attr("d", _.line);
    path.attr("d", _.line);

    var curve = _.vis.selectAll("path.curve")
      .data(_.getCurve);
    curve.enter().append("path")
      .attr("class", "curve");
    curve.attr("d", _.line);

    _.vis.selectAll("text.controltext")
      .attr("x", _.x)
      .attr("y", _.y);
    _.vis.selectAll("text.t")
      .text("t=" + _.t.toFixed(2));
  },
  interpolate: function(d, p) {
    var _ = this;

    if (arguments.length < 2) p = _.t;
    var r = [];
    for (var i = 1; i < d.length; i++) {
      var d0 = d[i - 1],
        d1 = d[i];
      r.push({
        x: d0.x + (d1.x - d0.x) * p,
        y: d0.y + (d1.y - d0.y) * p
      });
    }
    return r;
  },
  getLevels: function(d, t_) {
    var _ = BC;

    if (arguments.length < 2) t_ = _.t;
    var x = [_.points.slice(0, d)];
    for (var i = 1; i < d; i++) {
      x.push(_.interpolate(x[x.length - 1], t_));
    }
    return x;
  },
  getCurve:function(d) {
    var _ = BC;

    var curve = _.bezier[d];
    if (!curve) {
      curve = _.bezier[d] = [];
      for (var t_ = 0; t_ <= 1; t_ += _.delta) {
        var x = _.getLevels(d, t_);
        curve.push(x[x.length - 1][0]);
      }
    }
    return [curve.slice(0, _.t / _.delta + 1)];
  },
  x: function(d) { return d.x; },
  y: function(d) { return d.y; },
  colour: function(d, i) {
    var _ = BC;

    _.stroke(-i);
    return d.length > 1 ? _.stroke(i) : "red";
  },
  init: function() {
    var _ = this;

    for (var i = 0; i < _.points.length; i++) {
      _.points[i]['x'] *= _.grid;
      _.points[i]['y'] *= _.grid;
    }
    
    _.errorText = $('#st p.text-error');
    _.pointsCont = $('#st .points');
    _.btnsToolbar = $('#st .btn-toolbar');
    
    _.pointsCont.on('click', '.point .plus', function () {
      var point = $(this).closest('.point'),
          newPoint = point.clone();
      newPoint.find('input.x').val('');
      newPoint.find('input.y').val('');
      newPoint.insertAfter(point);
      _.updatePoints();
    });

    _.pointsCont.on('click', '.point .minus', function () {
      $(this).closest('.point').remove();
      _.updatePoints();
    });
    
    _.btnsToolbar.on('click', '.submit', function () {
      var x, y, 
          f = false,
          arr = [],
          points = $('#st .points .point');
      points.find('input').removeClass('error');
      for (var i = 0; i < points.length; i++) {
        x = $(points[i]).find('input.x');
        y = $(points[i]).find('input.y');
        if (x.val() == '') {
          x.addClass('error');
          f = true;
        }
        if (y.val() == '') {
          y.addClass('error');
          f = true;
        }
        arr.push({
          x: x.val() * _.grid,
          y: y.val() * _.grid
        });
      }
      if (f) {
        $('#st p.text-error').removeClass('hidden');
      } else {
        $('#st p.text-error').addClass('hidden');
        _.points = arr;
        _.rebuild();
      }
    });

    _.btnsToolbar.on('click', '.pause, .play, .stop', function () {
      $(this).addClass('active').siblings('.btn').removeClass('active');
      _.pause = $(this).hasClass('pause');
      _.play = $(this).hasClass('play');
    });

    _.btnsToolbar.on('click', '.step', function () {
      $(this).addClass('active').siblings('.btn').removeClass('active');
      _.stepped = $(this).data('on');
      _.rebuild();
    });

    _.btnsToolbar.on('change', '.speed', function () {
      _.speed = $(this).val();
    });
  }
};

$(function () {
  BC.init();
  BC.buildFromPoints();
  BC.updatePoints();
  BC.rebuild();
});