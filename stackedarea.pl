#!/usr/bin/perl
use strict;

use Chart::Clicker;
use Chart::Clicker::Context;
use Chart::Clicker::Data::DataSet;
use Chart::Clicker::Data::Marker;
use Chart::Clicker::Data::Series;
use Geometry::Primitive::Rectangle;
use Graphics::Color::RGB;
use Chart::Clicker::Renderer::StackedArea;

my $cc = Chart::Clicker->new(width => 550, height => 300, format => 'pdf');

my @hours = qw(
    1 2 3 4 5 6 7 8 9 10 11 12
);
my @bw1 = qw(
    5.8 5.0 4.9 4.8 4.5 4.25 3.5 2.9 2.5 1.8 .9 .8
);
my @bw2 = qw(
    .7 1.1 1.7 2.5 3.0 4.5 5.0 4.9 4.7 4.8 4.2 4.4
);
my @bw3 = qw(
    .3 1.4 1.2 1.5 4.0 3.5 2.0 1.9 2.7 4.2 3.2 1.1
);

my $series1 = Chart::Clicker::Data::Series->new(
    keys    => \@hours,
    values  => \@bw1,
);
my $series2 = Chart::Clicker::Data::Series->new(
    keys    => \@hours,
    values  => \@bw2,
);

my $series3 = Chart::Clicker::Data::Series->new(
    keys    => \@hours,
    values  => \@bw3,
);


$cc->border->width(0);
$cc->background_color(
    Graphics::Color::RGB->new(red => .95, green => .94, blue => .92)
);
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

$cc->plot->grid->background_color->alpha(0);
my $ds = Chart::Clicker::Data::DataSet->new(series => [ $series1, $series2, $series3 ]);

$cc->add_to_datasets($ds);

my $defctx = $cc->get_context('default');

$cc->legend->visible(0);
# $defctx->range_axis->label('Lorem');
# $defctx->domain_axis->label('Ipsum');
$defctx->range_axis->brush->width(0);
$defctx->domain_axis->brush->width(0);
# $defctx->range_axis->show_ticks(0);
# $defctx->domain_axis->show_ticks(0);

# $defctx->domain_axis->tick_label_angle(0.785398163);
$defctx->range_axis->label_font->family('Hoefler Text');
$defctx->range_axis->tick_font->family('Gentium');
$defctx->domain_axis->tick_font->family('Gentium');
$defctx->domain_axis->label_font->family('Hoefler Text');
$defctx->renderer(Chart::Clicker::Renderer::StackedArea->new(opacity => .75));
$defctx->renderer->brush->width(2);

$cc->legend->font->family('Hoefler Text');

$cc->draw;
$cc->write('foo.pdf');
