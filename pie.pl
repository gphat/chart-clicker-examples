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

my $cc = Chart::Clicker->new(width => 500, height => 400, format => 'pdf');

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
$cc->background_color(
    Graphics::Color::RGB->new(red => .95, green => .94, blue => .92)
);

$cc->border->width(0);
my $grey = Graphics::Color::RGB->new(
    red => .36, green => .36, blue => .36, alpha => 1
);
my $moregrey = Graphics::Color::RGB->new(
    red => .71, green => .71, blue => .71, alpha => 1
);
my $orange = Graphics::Color::RGB->new(
    red => .88, green => .48, blue => .09, alpha => 1
);
$cc->color_allocator->colors([ $grey, $moregrey, $orange ]);

$cc->legend->font->family('Hoefler Text');

my $ds = Chart::Clicker::Data::DataSet->new(series => [ $series1, $series2, $series3 ]);

$cc->add_to_datasets($ds);

my $defctx = $cc->get_context('default');
my $pie = Chart::Clicker::Renderer::Pie->new;
$pie->brush->width(6);
$pie->border_color(Graphics::Color::RGB->new(red => .95, green => .94, blue => .92));
$defctx->renderer($pie);
$defctx->domain_axis->hidden(1);
$defctx->range_axis->hidden(1);
$cc->plot->grid->visible(0);
$cc->legend->font->size(16);

$cc->draw;
$cc->write('foo.pdf');
