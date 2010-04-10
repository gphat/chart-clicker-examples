#!/usr/bin/perl
use strict;

use Chart::Clicker;
use Chart::Clicker::Context;
use Chart::Clicker::Data::DataSet;
use Chart::Clicker::Data::Marker;
use Chart::Clicker::Data::Series;
use Chart::Clicker::Renderer::PolarArea;
use Geometry::Primitive::Rectangle;
use Graphics::Color::RGB;

my $cc = Chart::Clicker->new(width => 300, height => 250);

my $series1 = Chart::Clicker::Data::Series->new(
    keys    => [ 1, 2,  3, 4, 5, 6, 7, 8,  9, 10 ],
    values  => [ 5, 10, 7, 4, 8, 9, 4, 10, 3, 6 ],
    name => 'Fails'
);
my $series2 = Chart::Clicker::Data::Series->new(
    keys    => [ 1, 2,  3,  4, 5, 6, 7,  8, 9, 10],
    values  => [ 5, 10, 16, 9, 4, 4, 11, 9, 3, 1],
    name => 'Whales'
);
my $series3 = Chart::Clicker::Data::Series->new(
    keys    => [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    values  => [ 2, 4, 6, 1, 4, 2, 1, 4, 2, 1],
    name => 'Tails'
);


my $ds = Chart::Clicker::Data::DataSet->new(series => [ $series1, $series2, $series3 ]);

my $lgreen = Graphics::Color::RGB->new(red => .69, green => .74, blue => .71);
my $green = Graphics::Color::RGB->new(red => .40, green => .49, blue => .45);
my $red = Graphics::Color::RGB->new(red => .65, green => .09, blue => .09);
$cc->color_allocator->colors([ $lgreen, $green, $red ]);

$cc->add_to_datasets($ds);

my $defctx = $cc->get_context('default');
my $polar = Chart::Clicker::Renderer::PolarArea->new;
$polar->border_color(Graphics::Color::RGB->new(red => 1, blue => 1, green => 1));
$polar->brush->width(2);
$defctx->renderer($polar);
$defctx->domain_axis->hidden(1);
$defctx->range_axis->hidden(1);
$cc->plot->grid->visible(0);

$cc->write_output('polararea.png');
