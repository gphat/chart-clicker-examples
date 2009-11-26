#!/usr/bin/perl
use strict;

use Chart::Clicker;
use Chart::Clicker::Context;
use Chart::Clicker::Data::DataSet;
use Chart::Clicker::Data::Marker;
use Chart::Clicker::Data::Series;
use Chart::Clicker::Renderer::Pie;
use Geometry::Primitive::Rectangle;
use Graphics::Color::RGB;

my $cc = Chart::Clicker->new(width => 300, height => 250, format => 'png');

my $series1 = Chart::Clicker::Data::Series->new(
    keys    => [ 1, 2, 3 ],
    values  => [ 1, 2, 3],
);
my $series2 = Chart::Clicker::Data::Series->new(
    keys    => [ 1, 2, 3],
    values  => [ 1, 1, 1 ],
);
my $series3 = Chart::Clicker::Data::Series->new(
    keys    => [ 1, 2, 3],
    values  => [ 1, 1, 0 ],
);

$cc->title->text('Pie');
$cc->title->padding->bottom(5);

my $ds = Chart::Clicker::Data::DataSet->new(series => [ $series1, $series2, $series3 ]);

$cc->add_to_datasets($ds);

my $defctx = $cc->get_context('default');
my $pie = Chart::Clicker::Renderer::Pie->new;
$pie->brush->width(3);
$pie->border_color(Graphics::Color::RGB->new(red => 1, green => 1, blue => 1));
$defctx->renderer($pie);
$defctx->domain_axis->hidden(1);
$defctx->range_axis->hidden(1);
$cc->plot->grid->visible(0);

$cc->write_output('pie.png');
